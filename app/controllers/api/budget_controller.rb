class Api::BudgetController < Api::BaseController
  def create
    render json: Budget.create!(budget_params)
  end

  def index
    Budget.where(user_id: current_user.id).each do |budget|
      budget.update!(spent: calculate_spent(budget.account_id))
    end

    render json: Budget.where(user_id: current_user.id).order(:account_id).reload
  end

  def show
    budget = Budget.find_by(user_id: current_user.id, account_id: params[:id])
    return head 404 unless budget

    budget.update!(spent: calculate_spent(budget.account_id))
    render json: budget
  end

  def destroy
    budget = Budget.find(params[:id])
    return head 404 unless budget

    budget.destroy
    head 200
  end

  private

  def budget_params
    {
      user_id: current_user.id,
      account_id: params[:account_id],
      account_name: params[:account_name],
      currency_code: params[:currency_code],
      goal: params[:goal],
      spent: calculate_spent
    }
  end

  def calculate_spent(account_id = params[:account_id])
    current_month_expenses = Transaction
                             .where(user_id: current_user.id)
                             .where(made_on: Date.today.beginning_of_month..Date.today)
                             .where('amount != ABS(amount)')
    current_month_expenses.where!(account_id:) if ['0', nil].exclude?(account_id)

    current_month_expenses.sum do |transaction|
      Rate.x(transaction.currency_code, transaction.amount)
    end.round(2).abs
  end
end
