require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:all) do
    @category = Category.new(name: "Test category")
    @photos = @category.photos
  end

  it 'has a name' do
    #@category.name.should eq "Test category"
    expect(@category.name).to eq "Test category"
  end
end
