class ConnectRequest < BaseRequest
  def connect(params)
    self.class.post(
      '/connect_sessions/create',
      body: params
    )
  end

  def refresh(params)
    self.class.put(
      "/connections/#{params[:connection_id]}/refresh"
    )
  end
end
