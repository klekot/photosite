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
    current_id = 0
    Photo.published.main_page.order(:order).each_with_index do |photo, i|
      if photo.order != current_id
        ph = Photo.find_by(order: id_array[i])
        ph.order = i
        ph.save
        current_id = ph.id
      end
    end
  end
end
