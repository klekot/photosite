class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @photos_in_category = []
    Photo.all.each do |photo|
      @photos_in_category.push photo if photo.category_id == @category.id
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.fetch(:category, {})
    end
end
