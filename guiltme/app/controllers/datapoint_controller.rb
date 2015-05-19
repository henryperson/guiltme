class DatapointController < ApplicationController
  def create
  	classification = Classification.find_or_new(params[:classification])
  	url = params[:url]

  	datapoint = Datapoint.find_by_url(url) || Datapoint.create(:url => url, :classification => classification)

  	redirect_to datapoint(datapoint)
  end

  def show
  	render json: Datapoint.find(params[:id])
  end
end
