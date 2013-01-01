require 'spec_helper'

describe User do
  before(:each) { @user = User.new(email:"rahmad@me.com") }

  it "should not be valid without an email address" do
    @user.email = nil
    @user.should_not be_valid
  end

  it "should authenticate with the correct password" do
    @user.password = "raheel"
    @user.save
    User.authenticate(@user.email, "raheel").should eq(@user)
  end
end
