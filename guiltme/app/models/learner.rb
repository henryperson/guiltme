class Learner
	class << self
		def instance
			@instance ||= new
		end

		def learn
			Classification.initialize_weight_vectors
			PerceptronLearner.learn
		end

		private :new
	end
end