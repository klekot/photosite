class PhotosController < ApplicationController
  before_action :set_photo, only: [:show]

  def index
    @photos = Photo.published.main_page.all
  end

  def show
  end

  # action for ajax request of saving new images order
  def order_update
    id_array = params[:ids].to_s.strip.split(%r{,\s*})
    update_order(id_array)
  end

  private

    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:name, :description, :image, :image_cache, :published, :main_page, :category_id)
    end
end
