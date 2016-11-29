class Photo < ApplicationRecord
  belongs_to :category
  has_and_belongs_to :tags
end
