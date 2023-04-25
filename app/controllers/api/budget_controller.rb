class Api::BudgetController < Api::BaseController
  def create
    render json: Budget.create!(budget_params)
  end

  def show
    budget = Budget.find(params[:id])
    budget.update!(spent: calculate_spent)
    render json: budget
  end

  private

  def budget_params
    {
      user_id: current_user.id,
      goal: params[:goal],
      spent: calculate_spent
    }
  end

  def calculate_spent
    current_month_expenses = Transaction
                             .where(user_id: current_user.id)
                             .where("made_on": Date.today.beginning_of_month..Date.today)
                             .where('amount != ABS(amount)')

    current_month_expenses.sum(:amount)
  end
end
