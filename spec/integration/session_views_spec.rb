require 'spec_helper'
require 'capybara/rspec'

describe "the sessions interface" do
  describe "the signin page" do
    before(:each) do
      visit signin_path
      @user = User.new(email:'rahmad@fitbit.com', password:'raheel')
    end

    it "should have fields for email and password" do
      page.should have_field :email
      page.should have_field :password
    end

    it "should sign in the filled in user" do
      @user.save
      fill_in 'Email', with:@user.email
      fill_in 'Password', with:@user.password
      #page.driver.post user_session_path, :user => {:email => user.email, :password => 'superpassword'}
      click_button 'Sign in'
      page.should have_content 'You are signed in'
      page.should have_link 'Logout', href:logout_path
    end
  end
end
