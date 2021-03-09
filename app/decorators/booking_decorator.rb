class BookingDecorator < Draper::Decorator
  
  delegate_all
  
  decorates_association :booking_products, with: BookingProductDecorator
  
  include Creatable
  
end
