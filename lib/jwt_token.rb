class JwtToken
  SECRET_KEY  = Rails.application.secrets.secret_key_base.to_s
  EXPIRE_TIME = 7.days

  def self.encode(payload, exp: EXPIRE_TIME.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY)[0]
  end
end
