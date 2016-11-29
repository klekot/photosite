class Category < ApplicationRecord
  has_many :photos

  mount_uploader :image, ImageUploader
end
