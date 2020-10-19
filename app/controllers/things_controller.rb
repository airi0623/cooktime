class ThingsController < ApplicationController
  
  def index
    thing = Thing.find(params[:id])
    render json: ingredients.things.select(:id, :thing-name)
  end

end
