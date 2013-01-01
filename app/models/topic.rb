class Topic < ActiveRecord::Base
  attr_accessible :name
  has_many :cards
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :user_id
end
