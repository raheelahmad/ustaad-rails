class HomeController < ApplicationController
  def index
    @latest_cards = Card.latest_cards
    session[:current_card_query_ids] = @latest_cards.map(&:id)
  end
end
