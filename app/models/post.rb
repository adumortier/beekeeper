class Post < ApplicationRecord

  has_many_attached :images
  
  belongs_to :user

  validates_presence_of :title, optional: true
  validates_presence_of :content, optional: true
end