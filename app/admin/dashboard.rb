ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
       panel "Последние добавленные фото" do
         ul do
           Photo.last(15).map do |photo|
             li link_to(photo.name, admin_photo_path(photo))
           end
         end
       end
      end
    end

  end # content
end
