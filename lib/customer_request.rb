class CustomerRequest < BaseRequest
  base_uri "#{base_uri}/customers"

  def create(email)
    self.class.post(
      '/',
      body: { data: { identifier: email } }
    )
  end

  def remove(customer_id)
    self.class.delete(
      "/#{customer_id}"
    )
  end
end
