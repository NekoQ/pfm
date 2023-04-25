class Api::TransactionsController < Api::BaseController
  def index
    transactions = Transaction.where(user_id: current_user.id)
    transactions = transactions.order('made_on desc').limit(10) if params[:last]
    transactions.where!(account_id: params[:account_id]) if params[:account_id].present?

    render json: transactions
  end

  def search
    transactions = Transaction
                   .where(user_id: current_user.id)
    transactions = transactions.where(account_id: params[:account_id]) if params[:account_id].present?

    render json: transactions.search(params[:query])
  end
end
