class Photo < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  mount_uploader :image, ImageUploader

  scope :published, -> () { where(published: 1) }
  scope :main_page, -> () { where(main_page: 1) }
end
