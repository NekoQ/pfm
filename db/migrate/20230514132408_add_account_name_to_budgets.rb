class AddAccountNameToBudgets < ActiveRecord::Migration[7.0]
  def change
    add_column :budgets, :currency_code, :string
  end
end
