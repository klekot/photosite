class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :get_rows, :update_order

  private

  def set_admin_locale
    I18n.locale = :ru
  end

  def get_rows
    Photo.published.main_page.order(:order)
  end

  def update_order(id_array)
    old_ordered_photos = []
    Photo.published.main_page.order(:order).each do |photo|
      old_ordered_photos.push photo
    end
    id_array.each_with_index do |id, i|
      ph = old_ordered_photos[i]
      ph.order = id
      ph.save
    end
  end
end
