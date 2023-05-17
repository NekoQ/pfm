class ImporterJob < ApplicationJob
  queue_as :default

  def perform(user)
    se_accounts = AccountsRequest.new.get(user.customer_id)['data']
    se_accounts.each do |se_account|
      account = se_account
                .merge(
                  'se_id' => se_account['id'],
                  'user_id' => user.id
                )
                .except('id', 'extra')

      db_account   = Account.find_by(se_id: account['se_id'])
      db_account ||= Account.create!(account)

      ActiveRecord::Base.transaction do
        se_transactions = TransactionsRequest
                          .new
                          .get(db_account.connection_id, db_account.se_id)['data']
        se_transactions.each do |se_transaction|
          transaction = se_transaction
                        .merge(
                          'se_id' => se_transaction['id'],
                          'account_id' => db_account.id,
                          'user_id': user.id
                        )
                        .except('id', 'extra', 'duplicated')

          next if Transaction.where(se_id: transaction['se_id']).exists?

          Transaction.create!(transaction)
        end
      end
    end
  end
end
