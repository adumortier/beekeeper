class Post < ApplicationRecord

  has_many_attached :images
  
  belongs_to :user

  validates_presence_of :title, optional: true
  validates_presence_of :content, optional: true

  def self.resize_image(image)
    ImageProcessing::MiniMagick.source(image).resize_to_limit(600, 600).convert("png").call
  end

end