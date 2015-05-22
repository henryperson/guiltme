class DatapointController < ApplicationController
  respond_to :json
  def create
  	classification = Classification.find_or_create(params[:classification])
  	datapoint = Datapoint.new_or_overwrite(params[:url], classification)
  	render json: datapoint
  	correct_classification = Classifier.classify_url(datapoint.url)
  	unless classification.name == correct_classification
 		correct_vector = Classification.find_by_name(correct_classification).vector
 		chosen_vector = classification.vector
 		feature_vector = FeatureVectorCreator.get_vector(datapoint.url)
  		PerceptronLearner.mira_update(correct_vector, chosen_vector, feature_vector)
  	end
  end
end
