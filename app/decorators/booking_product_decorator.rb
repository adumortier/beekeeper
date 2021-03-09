class BookingProductDecorator < Draper::Decorator
  
  delegate_all

  include Creatable

  def product_description
    object.product.description
  end

  def product_season
    object.product.season
  end
  
  def product_year
    object.product.year
  end

  def season_year
    object.product.season + ' ' + object.product.year.to_s
  end
  
end
