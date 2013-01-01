require 'spec_helper'
require 'capybara/rspec'
require_relative '../support/helper.rb'
describe "home views" do

  it "should have a login prompt if not logged in" do
    signin
  end
end
