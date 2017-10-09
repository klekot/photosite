ActiveAdmin.register Category do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
  permit_params :position, :name, :description, :image
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    selectable_column
    column "Название", :name
    column "Описание", :description
    column "Позиция в меню", :position
    actions
  end

  show do |category|
    attributes_table do
      row "Название" do
        image_tag(category.name)
      end
      row "Описание" do
        category.description
      end
      row "Позиция в меню" do
        category.position
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs :name, :description, :position
    f.actions
  end

  controller do
    def create
      @category = Category.new
      @category.name = params[:category][:name]
      @category.description = params[:category][:description]
      @category.image = params[:category][:image]
      @category.position = params[:category][:position]
      if @category.save
        render 'edit'
      else
        render 'new'
      end
    end

    def edit
      @category = Category.find params[:id]
    end

    def update
      @category = Category.find params[:id]
      @category.name = params[:category][:name]
      @category.description = params[:category][:description]
      @category.position = params[:category][:position]
      if @category.save
        render 'edit'
      else
        render 'new'
      end
    end
  end
end
