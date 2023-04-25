class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :user_id
      t.string :se_id
      t.string :account_id
      t.string :mode
      t.string :status
      t.string :made_on
      t.float :amount
      t.string :currency_code
      t.string :description
      t.string :category

      t.timestamps
    end
  end
end
