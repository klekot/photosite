class TagsController < ApplicationController
  before_action :set_tag, only: [:show]

  def index
    @tags = Tag.not_empty.to_a
    @tags.sort! { |a,b| a.name.downcase <=> b.name.downcase }
  end

  def show
    @photos_with_tag = []
    Photo.all.each do |photo|
      @photos_with_tag.push photo if photo.tags.include? @tag
    end
  end

  private

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.fetch(:tag, {})
  end
end
