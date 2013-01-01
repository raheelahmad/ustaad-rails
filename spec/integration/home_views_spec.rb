require 'spec_helper'
require 'capybara/rspec'
require_relative '../support/helper.rb'
describe "home views" do

  it "should have a login prompt if not logged in" do
    user = signin
    page.should have_content "You are signed in"
    page.should have_content user.email
  end
end
