def signin
  @user = User.new(email:'rahmad@fitbit.com', password:'raheel')
  @user.save
  visit signin_path
  fill_in 'Email', with:@user.email
  fill_in 'Password', with:@user.password
  #page.driver.post user_session_path, :user => {:email => user.email, :password => 'superpassword'}
  click_button 'Sign in'
  @user
end
