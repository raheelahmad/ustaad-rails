require 'spec_helper'
require 'capybara/rspec'
require_relative "../support/helper.rb"

describe "the sessions interface" do
  describe "the signin page" do
    before(:each) do
      visit signin_path
    end

    it "should have fields for email and password" do
      page.should have_field :email
      page.should have_field :password
    end

    it "should sign in the filled in user" do
      user = signin
      page.should have_content 'You are signed in'
      page.should have_content user.name
      page.should have_link 'Logout', href:logout_path
    end
  end
end
