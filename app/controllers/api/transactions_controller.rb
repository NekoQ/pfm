class Api::TransactionsController < Api::BaseController
  def index
    transactions = Transaction.where(user_id: current_user.id).order(:id)
    transactions.where!(account_id: params[:account_id]) if [nil, '', '0'].exclude?(params[:account_id])

    if params[:last]
      transactions = transactions.order('made_on desc').limit(10)
      return render json: transactions
    end

    transactions = transactions.search(params[:query]) if params[:query].present?

    render json: paginate(transactions)
  end

  def search
    transactions = Transaction
                   .where(user_id: current_user.id)
    transactions = transactions.where(account_id: params[:account_id]) if [nil, '', '0'].exclude?(params[:account_id])
    render json: paginate(transactions.search(params[:query]))
  end
end
