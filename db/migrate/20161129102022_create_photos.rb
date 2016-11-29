class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :description
      t.string :image
      t.boolean :published
      t.boolean :main_page
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
