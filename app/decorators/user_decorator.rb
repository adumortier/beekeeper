class UserDecorator < Draper::Decorator

  delegate_all

  include Creatable

  def full_name
    object.first_name.titleize + ' ' + object.last_name.titleize
  end

  def full_address
    object.address + ', ' + object.zip_code + '  ' + object.city.titleize
  end

end
