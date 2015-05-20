class DatapointController < ApplicationController
  respond_to :json
  def create
  	classification = Classification.find_or_new(params[:classification])
  	url = params[:url]

  	datapoint = Datapoint.find_by_url(url) || Datapoint.create(:url => url, :classification => classification)

  	redirect_to datapoint_path(datapoint)
  end

  def show
  	render json: Datapoint.find(params[:id])
  end
end
