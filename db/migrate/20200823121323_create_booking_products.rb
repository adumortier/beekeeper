class CreateBookingProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :booking_products do |t|
      t.references :booking, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity
      t.timestamps 
    end
  end
end
