require 'spec_helper'
require 'capybara/rspec'

describe "the users interface" do
  describe "the signup page" do
    before(:each) do
      @user = User.new(email:'rahmad@fitbit.com', password:'raheel')
      visit signup_path
    end 

    it "should have fields for email and passwords" do
      page.should have_field :email
      page.should have_field :password
      page.should have_field :password_confirmation
    end

    it "should signup the filled in user" do
      fill_in 'Email', with:@user.email
      fill_in 'Password', with:@user.password
      fill_in 'Password confirmation', with:@user.password
      click_button 'Sign up'

      current_path.should eq(root_path)
      page.should have_content "You have been signed up"
      page.should have_content @user.email
    end

    it "should fail signup for mismatched password" do
      fill_in "Email", with:@user.email
      fill_in "Password", with:@user.password
      fill_in "Password confirmation", with:(@user.password + "xx")
      click_button 'Sign up'
      
      current_path.should eq(users_path)
      page.should have_content "Error signing up"
    end
  end
end
