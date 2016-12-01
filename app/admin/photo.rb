ActiveAdmin.register Photo do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters

  permit_params :order, :name, :description, :image, :published, :main_page, :category_id,
                tag_ids: []

  index do
    selectable_column
    column :order
    column "Фото" do |photo|
      image_tag photo.image.url, class: 'admin-photos-index'
    end
    column :name
    column :category_id
    column :tag_ids do |photo|
      (photo.tags.map{ |t| t.name }).join(', ').html_safe
    end
    column :published
    column :main_page
    actions
  end

  show do |photo|
    attributes_table do
      row "Фото" do
        image_tag(photo.image.url)
      end
      row "Описание" do
        photo.description
      end
      row :tag_ids do |photo|
        (photo.tags.map{ |t| t.name }).join(', ').html_safe
      end
    end
  end

  form do |f|
    photo_tags = []
    (Tag.all.includes(:photos).where("photos.id" => f.object.id)).each do |tag|
      photo_tags << tag.name
    end
    f.semantic_errors
    f.inputs :name, :description, :order
    f.inputs "Загрузить", :multipart => true do
      f.input :image, :as => :file, :hint => f.object.image.present? \
        ? image_tag(f.object.image.url, class: 'admin-photo-form')
      : content_tag(:span, "файл пока не выбран")
      f.input :image_cache, :as => :hidden
    end
    f.inputs :category, :published, :main_page
    input :tag_ids, input_html: { value: photo_tags.join(', ') }
    f.actions
  end

  controller do
    def create
      @photo = Photo.new
      if @photo.save
        add_tags_to_photo params[:photo][:tag_ids]
        render 'edit'
      else
        render 'new'
      end
    end

    def edit
      @photo = Photo.find params[:id]
      tags = Tag.includes(:photos).where("photos.id" => @photo.id)
      photo_tags = []
      tags.each do |tag|
        photo_tags.push(tag.name)
      end
      @tags_string = photo_tags.join(", ")
    end

    def update
      @photo = Photo.find params[:id]
      add_tags_to_photo params[:photo][:tag_ids]
      render 'edit'
    end

    private

    def add_tags_to_photo params_tags
      photo_tags = []
      params_tags.split(',').each do |tag|
        if Tag.find_by(name: tag.strip)
          t = Tag.find_by(name: tag.strip)
        else
          t = Tag.new name: tag.strip
        end
        t.save
        photo_tags.push t
        @photo.tags.clear
      end
      @photo.tags << photo_tags
    end
  end

end
