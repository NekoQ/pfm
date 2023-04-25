class BaseRequest
  include HTTParty
  base_uri 'https://www.saltedge.com/api/v5'
  headers 'app-id': Rails.application.secrets.app_id,
          'secret': Rails.application.secrets.secret

  def initialize; end
end
