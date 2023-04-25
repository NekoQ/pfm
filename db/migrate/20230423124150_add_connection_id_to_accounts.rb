class AddConnectionIdToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :connection_id, :string
  end
end
