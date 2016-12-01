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
    count = 1
    id_array.each do |id|
      photo = Photo.find(id)
      photo.order = count
      photo.save
      count += 1
    end
  end
end
