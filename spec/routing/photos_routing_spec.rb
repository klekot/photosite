require "rails_helper"

RSpec.describe PhotosController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/photos").to route_to("photos#index")
    end

    it "routes to #show" do
      expect(:get => "/photos/1").to route_to("photos#show", :id => "1")
    end

  end
end
