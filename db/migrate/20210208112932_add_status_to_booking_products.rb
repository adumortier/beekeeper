class AddStatusToBookingProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :booking_products, :status, :integer, default: 0
  end
end
