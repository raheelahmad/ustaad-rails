def random_string(len)
  rand(36**len).to_s(36)
end

def signin
  email = random_string(6) + "@gmail.com"
  name = "sternameksks"
  user = User.new(email:email, name:name, password:'raheel')
  user.save
  visit signin_path
  fill_in 'Email', with:user.email
  fill_in 'Password', with:user.password
  #page.driver.post user_session_path, :user => {:email => user.email, :password => 'superpassword'}
  click_button 'Sign in'
  cookies[:remember_token] = user.remember_token
  user
end
