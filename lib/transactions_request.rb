class TransactionsRequest < BaseRequest
  base_uri "#{base_uri}/transactions"

  def get(connection_id, account_id)
    self.class.get(
      '/',
      query: { connection_id:, account_id: }
    )
  end
end
