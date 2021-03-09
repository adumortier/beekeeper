module Creatable

  def published_at
    object.created_at.strftime('%d/%m/%Y')
  end

end