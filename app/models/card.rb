class Card < ActiveRecord::Base
  attr_accessible :answer, :question, :answer_image, :question_image, :public
  has_attached_file :answer_image
  has_attached_file :question_image
  validates_presence_of :answer, :question
  after_create :default_values
  belongs_to :topic

  def self.latest_cards
    latest = Card.where(public:true).order("updated_at DESC")
  end

  def previous(query)
    unless query.nil?
      card_index = query.find_index(self.id)
      previous_card_id = query[card_index - 1] unless card_index.zero?
      if previous_card_id && previous_card_id >= 0
        Card.find(previous_card_id) 
      end
    end
  end

  def next(query)
    unless query.nil?
      card_index = query.find_index(self.id)
      next_card_id = query[card_index + 1] unless card_index >= query.length - 1
      if next_card_id
        Card.find(next_card_id) 
      end
    end
  end

  private

    def default_values
      self.public = false
    end
end
