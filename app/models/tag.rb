class Tag < ApplicationRecord
  has_and_belongs_to_many :photos
  accepts_nested_attributes_for :photos

  scope :not_empty, -> () {
     Tag.joins("LEFT JOIN photos_tags ON tags.id = photos_tags.tag_id")
        .where("photos_tags.tag_id IS NOT NULL")
        .select("DISTINCT tags.*")
  }

end
