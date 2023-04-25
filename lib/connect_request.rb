class ConnectRequest < BaseRequest
  base_uri "#{base_uri}/connect_sessions"

  def connect(params)
    self.class.post(
      '/create',
      body: params
    )
  end

  def refresh(params)
    self.class.post(
      '/refresh',
      body: params
    )
  end
end
