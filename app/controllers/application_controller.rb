class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :get_rows, :update_order

  private

  def set_admin_locale
    I18n.locale = :ru
  end

  def get_rows
    Photo.all.order(:order)
  end

  def update_order(id_array)
    Photo.all.order(:order).each_with_index do |photo, i|
      if photo.order != id_array[i]
        ph = Photo.find_by(order: id_array[i])
        ph.order = i
        ph.save
      end
    end
  end
end
