class Transaction < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_in_transactions,
                  against: %i[description amount currency_code category],
                  using: { tsearch: { prefix: true } }

  def self.search(query)
    return Transaction.none if query.blank?

    search_in_transactions(query).with_pg_search_rank
  end
end
