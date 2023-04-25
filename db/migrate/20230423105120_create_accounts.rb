class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :user_id
      t.string :se_id
      t.string :name
      t.string :nature
      t.float :balance
      t.string :currency_code

      t.timestamps
    end
  end
end
