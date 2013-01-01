class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  validates_presence_of :email
  has_many :topics

  has_secure_password

  def latestTopics
    self.topics.order("updated_at DESC").limit(3)
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
