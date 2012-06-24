require 'spec_helper'

describe "Static pages" do
  subject { page }

  describe "Home page" do
    before { visit root_path }
    it { should have_selector('h1', text: 'FancyLoop') }
    it { should have_selector('title',
                        :text => "FancyLoop | Home") }
  end

  describe "About page" do
    before { visit about_path }
    it { should have_selector('h1', text: 'About FancyLoop') }
    it { should have_selector('title',
                        :text => "FancyLoop | About") }
  end
end
