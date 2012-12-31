class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @card = Card.new
    @card.topic_id = @topic.id
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      flash[:notice] = "#{@topic.name} created. Add cards below"
      redirect_to topic_path(@topic)
    else
      flash[:notice] = "Could not create the topic. See errors below"
      render "new"
    end
  end
end
