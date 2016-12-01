class AddOrderToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :order, :integer
  end
end
