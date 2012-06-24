require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'FancyLoop'" do
      visit '/static_pages/home'
      page.should have_content('FancyLoop')
    end
    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title',
                        :text => "FancyLoop | Home")
    end
  end

  describe "About page" do

    it "should have the content 'About FancyLoop'" do
      visit '/static_pages/about'
      page.should have_content('About FancyLoop')
    end
    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title',
                        :text => "FancyLoop | About")
    end
  end
end
