class RatesRequest < BaseRequest
  base_uri "#{base_uri}/rates"

  def get
    self.class.get('/')
  end
end
