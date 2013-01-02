class Topic < ActiveRecord::Base
  attr_accessible :name
  has_many :cards
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :user_id

  def display_name
    comps = [self.name]
    comps << " (#{self.cards.count})" if self.cards.count > 0
    comps.join(" ")
  end
end
