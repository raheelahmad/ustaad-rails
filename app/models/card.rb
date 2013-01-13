class Card < ActiveRecord::Base
  attr_accessible :answer, :question, :answer_image, :question_image, :public
  has_attached_file :answer_image
  has_attached_file :question_image
  validates_presence_of :answer, :question
  after_create :default_values
  belongs_to :topic

  def self.latest_cards
    Card.where(public:true).order("updated_at DESC")
  end

  private

    def default_values
      self.public = false
    end
end
