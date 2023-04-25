class Api::AccountsController < Api::BaseController
  def index
    render json: Account.where(user_id: current_user.id)
  end
end
