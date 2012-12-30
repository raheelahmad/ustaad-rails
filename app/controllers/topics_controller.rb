class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      flash[:notice] = "#{@topic.name} created. Add cards below"
    end
  end
end
