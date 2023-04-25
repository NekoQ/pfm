class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.string :code
      t.decimal :rate

      t.timestamps
    end
  end
end
