def signin
  email = rand(36**6).to_s(36) + "@gmail.com"
  user = User.new(email:email, password:'raheel')
  user.save
  visit signin_path
  fill_in 'Email', with:user.email
  fill_in 'Password', with:user.password
  #page.driver.post user_session_path, :user => {:email => user.email, :password => 'superpassword'}
  click_button 'Sign in'
  cookies[:remember_token] = user.remember_token
  user
end
