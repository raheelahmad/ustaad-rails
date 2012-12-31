class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  validates_presence_of :email

  has_secure_password

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
