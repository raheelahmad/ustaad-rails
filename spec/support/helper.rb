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

def add_some_cards_to_topic(options)
  topic = options[:topic]
  make_public = options[:public]
  cards = []
  6.times do |i|
    card = Card.new(question:random_string(6), answer:random_string(6))
    card.topic_id = topic.id
    card.public = make_public
    card.save
    cards << card
  end

  cards
end
