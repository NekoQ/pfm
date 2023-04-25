class Api::UsersController < ApplicationController
  before_action :find_user, only: %i[show destroy]

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)

    response    = CustomerRequest.new.create(user.email)
    customer_id = response.dig('data', 'id')

    return render json: { errors: ['Failed to create user'] }, status: 409 unless customer_id

    user.customer_id = customer_id

    return head :created if user.save

    render json: { errors: user.errors.full_messages }, status: 409
  end

  def destroy
    se_customer = CustomerRequest.new
    se_customer.remove(user.customer_id)
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
