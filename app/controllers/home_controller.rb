class HomeController < ApplicationController
  def index
    @latest_cards = Card.latest_cards
  end
end
