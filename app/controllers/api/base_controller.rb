class Api::BaseController < ApplicationController
  attr_reader :current_user

  rescue_from ActionController::BadRequest, with: :bad_request
  rescue_from Exception, with: :handle_error
  def append_info_to_payload(payload)
    super

    payload[:user_id] = current_user.try(:id)
  end

  private

  before_action :authenticate_user

  def paginate(collection)
    per_page = params[:per_page] || 20
    from_id  = params[:from_id] || 0
    next_id  = nil

    paginated_collection = collection.where(id: from_id..).limit(per_page + 1).to_a
    next_id              = paginated_collection.pop.id if paginated_collection.size > per_page

    { data: paginated_collection, meta: { next_id: } }
  end

  def authenticate_user
    token = request.headers['Authorization']
    pp token

    user_id       = JwtToken.decode(token)['user_id']
    pp user_id
    @current_user = CachedUser.find(user_id)
  rescue ActiveRecord::RecordNotFound, JWT::DecodeError => e
    pp e
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
