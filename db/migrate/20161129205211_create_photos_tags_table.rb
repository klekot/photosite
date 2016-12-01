class CreatePhotosTagsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :photos_tags do |t|
      t.references :photo, foreign_key: true
      t.references :tag, foreign_key: true
    end
  end
end
