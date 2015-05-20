class LearningController < ApplicationController
	def learn
		if params[:auth] == 123
			render json: Learner.learn.to_json
		else
			render json: {"error" => "invalid credentials"}.to_json
		end
	end
end
