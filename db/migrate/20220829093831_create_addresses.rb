class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :area
      t.string :city
      t.string :pincode
      t.string :state

      t.timestamps
    end
  end
end
