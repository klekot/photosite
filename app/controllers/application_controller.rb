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
    old_order = []
    Photo.published.main_page.order(:order).each do |photo|
      old_order.push photo.id
    end
    Photo.all.each do |photo|
      photo.order=nil
      photo.save
    end
    id_array.each_with_index do |ida, i|
      if old_order[ida.to_s.to_i]
        ph = Photo.find(old_order[ida.to_s.to_i])
        ph.order = i
        ph.save
      end
    end
    last_order_number = 0
    last_order_number = (Photo.where.not(order: nil).order(order: :desc).first).order if Photo.where.not(order: nil).size > 0
    Photo.where(order: nil).each_with_index do |photo, i|
      photo.order=last_order_number + 1 + i
      photo.save
    end
  end
end
