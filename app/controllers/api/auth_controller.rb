class Api::AuthController < ApplicationController
  # POST /auth/sign_in
  def sign_in
    user = User.find_by(email: params[:email])
    return unauthorized unless user && user.authenticate(params[:password])

    token = JwtToken.encode({ user_id: user.id })
    time  = (Time.now + JwtToken::EXPIRE_TIME).utc
    render json: { name: user.name, token:, expires_at: time }
  end

  def unauthorized
    render json: { errors: ['Wrong credentials'] }, status: :unauthorized
  end
end
