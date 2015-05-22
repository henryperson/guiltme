class DatapointController < ApplicationController
  respond_to :json
  def create
  	classification = Classification.find_or_create(params[:classification])
  	puts classification.as_json
  	render json: Datapoint.new_or_overwrite(params[:url], classification)
  end
end
