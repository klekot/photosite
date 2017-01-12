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
    #fix old order of pix
    id_order = []
    id_array.each do |ida|
      id_order.push (Photo.find_by(order: ida)).id
    end
    #reset all order numbers of all pix
    Photo.all.each do |photo|
      photo.order=nil
      photo.save
    end
    if id_array.size == id_order.size
      # id_array.each_with_index do |ida, i|
      #   if id_order[ida.to_s.to_i]
      #     ph = Photo.find(id_order[ida.to_s.to_i])
      #     ph.order = i
      #     ph.save
      #   end
      # end
      id_order.each_with_index do |id, i|
        p = Photo.find(id)
        p.order = i
        p.save
      end
      last_order_number = 0
      last_order_number = (Photo.where.not(order: nil).order(order: :desc).first).order if Photo.where.not(order: nil).size > 0
      Photo.where(order: nil).each_with_index do |photo, i|
        photo.order=last_order_number + 1 + i
        photo.save
      end
    else
      puts "Error!!!"
      return
    end
  end
end
