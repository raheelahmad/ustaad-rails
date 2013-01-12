require 'spec_helper'
require 'capybara/rspec'

describe "the users interface" do
  describe "the signup page" do
    before(:each) do
      @user = User.new(email:'rahmad@fitbit.com', name:'Raheel', password:'raheel')
      visit signup_path
    end 

    it "should have fields for email and passwords" do
      page.should have_field :email
      page.should have_field :name
      page.should have_field :password
      page.should have_field :password_confirmation
    end

    it "should signup the filled in user" do
      fill_in 'Email', with:@user.email
      fill_in 'Password', with:@user.password
      fill_in 'Name', with:@user.name
      fill_in 'Password confirmation', with:@user.password
      click_button 'Sign up'

      current_path.should eq(root_path)
      page.should have_content "You have been signed up"
      page.should have_link @user.name, href:profile_path
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

  describe "the profile#show page" do
    before(:each) do
      @user = signin
      visit profile_path
    end

    it "should display the signed in user details" do
      page.should have_field 'Name', with:@user.name
      page.should have_field :password
      page.should have_field :password_confirmation
    end

    it "should edit the name and passwords" do
      new_name = "Raheel Bhai"
      new_password = random_string(10)
      page.fill_in 'Name', with:new_name
      page.fill_in 'Password', with:new_password
      page.fill_in 'Password confirmation', with:new_password
      page.click_button 'Update User'
      page.should have_content "Your profile has been updated"
    end

    it "should fail the update for mismatched passwords" do
      page.fill_in 'Password', with:'pass1'
      page.fill_in 'Password confirmation', with:'pass2'
      click_button 'Update User'
      page.should have_content "Error updating your profile"
    end
  end
end
