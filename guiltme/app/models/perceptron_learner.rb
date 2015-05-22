class PerceptronLearner < Learner
	class << self

		def instance
			@instance ||= new
		end

		def perceptron_update(correct_vector, chosen_vector, feature_vector)
			correct_vector.add feature_vector
			chosen_vector.subtract feature_vector
		end

		def mira_update(correct_vector, chosen_vector, feature_vector)
			tau = (((chosen_vector - correct_vector) * feature_vector) + 1).to_f / (2 * (feature_vector * feature_vector))
			correct_vector.add feature_vector.constant_mult tau
			chosen_vector.subtract feature_vector.constant_mult tau
		end

		def learn(update = :mira, cycles = 100)
			feature_vectors = {}
			cycles.times do |i|
				Datapoint.all.each do |datapoint|
					classification = Classifier.classify_url(datapoint.url)
					unless classification == datapoint.classification.name
						feature_vectors[datapoint.url] ||= FeatureVectorCreator.get_vector(datapoint.url)
						mira_update(datapoint.classification.vector, Classification.find_by_name(classification).vector, feature_vectors[datapoint.url])
					end
				end
			end
		end

		private :new
	end
end