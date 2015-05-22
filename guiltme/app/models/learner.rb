class Learner
	class << self
		@@LAPLACE_FACTOR = 1
		def instance
			@instance ||= new
		end

		def learn
			setup
			PerceptronLearner.learn
		end

		private :new
		private
		def setup
			Classification.initialize_weight_vectors
		end
	end
end