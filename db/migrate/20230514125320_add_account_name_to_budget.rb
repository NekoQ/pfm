class AddAccountNameToBudget < ActiveRecord::Migration[7.0]
  def change
    add_column :budgets, :account_name, :string
  end
end
