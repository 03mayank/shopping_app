class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address
      t.float :total_amount
      t.timestamp :time_of_order
      t.timestamp :time_of_delivery

      t.timestamps
    end
  end
end
