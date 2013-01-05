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

  def show
    if !current_user  
      raise ActiveRecord::RecordNotFound.new
    end
    current_user.topics.each do |topic|
      card = topic.cards.where(id: params[:id])
      @card = card.first if card
    end
  end

  def destroy
    card = Card.find(params[:id])
    name = card.question; topic = card.topic
    card.destroy
    redirect_to topic_path(topic), notice:"#{name} was deleted"
  end
end
