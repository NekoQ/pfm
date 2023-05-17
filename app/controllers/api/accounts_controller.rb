class Api::AccountsController < Api::BaseController
  def index
    accounts      = Account.where(user_id: current_user.id)

    return render json: [] unless accounts.present?

    total_balance = accounts.sum { |account| Rate.x(account.currency_code, account.balance) }
    total_account = accounts.first.attributes.merge(
      id: '0',
      name: 'All accounts',
      nature: 'Total balance',
      balance: total_balance.round(2),
      currency_code: 'USD'
    )

    render json: [total_account] + accounts
  end
end
