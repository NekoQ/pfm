class AccountsRequest < BaseRequest
  base_uri "#{base_uri}/accounts"

  def get(customer_id)
    self.class.get(
      '/',
      query: { customer_id: }
    )
  end
end
