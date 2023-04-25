class CreateBudgets < ActiveRecord::Migration[7.0]
  def change
    create_table :budgets do |t|
      t.string :user_id
      t.string :account_id
      t.float :goal
      t.string :spent

      t.timestamps
    end
  end
end
