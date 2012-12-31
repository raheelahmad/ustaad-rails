class CardsController < ApplicationController
  def create
    topic_id = params[:card].delete(:topic_id)
    @card = Card.new(params[:card])
    @card.topic_id = topic_id
    if @card.save
      redirect_to topic_path(@card.topic), notice:"Card added"
    else
      flash[:error] = "Could not add card."
      render "new"
    end
  end
end
