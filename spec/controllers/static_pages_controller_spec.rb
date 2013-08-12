require 'spec_helper'

describe StaticPagesController do

  describe "GET #home" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET #pricing" do
    it "returns http success" do
      get 'pricing'
      response.should be_success
    end
  end

  describe "GET #about" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

end
