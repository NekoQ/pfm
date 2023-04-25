class Api::BaseController < ApplicationController
  attr_reader :current_user

  before_action :authenticate_user
  # rescue_from Exception, with: :handle_error
  rescue_from ActionController::BadRequest, with: :bad_request
  def append_info_to_payload(payload)
    super
    payload[:user_id] = current_user.id
  end

  private

  def authenticate_user
    token = request.headers['Authorization']

    user_id       = JwtToken.decode(token)['user_id']
    @current_user = CachedUser.find(user_id)
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    render json: { errors: ['Invalid authorization token'] }, status: :unauthorized
  end

  def handle_error(error)
    pp error
    render json: { errors: ['Something went wrong'] }, status: 500
  end

  def bad_request
    render json: { errors: ['Bad request'] }, status: 400
  end
end
