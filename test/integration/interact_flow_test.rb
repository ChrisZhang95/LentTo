require 'test_helper'
#require 'spec_helper'
#require 'capybara/rspec'


describe "on the index page" do
    before(:each) do
      visit home_show_path
    end


it "display the home page" do
visit announcements_path
expect(page).to have_content(announcement.title)

end

end
