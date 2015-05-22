class PerceptronLearner < Learner
	class << self
		# Poor implementation of when to stop
		@@CYCLES = 100

		def instance
			@instance ||= new
		end

		def learn
			feature_vectors = {}
			@@CYCLES.times do |i|
				Datapoint.all.each do |datapoint|
					classification = Classifier.classify_url(datapoint.url).max_by{|k,v| v}[0]
					unless classification == datapoint.classification.name
						unless feature_vectors[datapoint.url]
							feature_vectors[datapoint.url] = FeatureVectorCreator.get_vector(datapoint.url)
						end
						puts "feature vector weights : "+ feature_vectors[datapoint.url].weights.to_s
						puts "datapoing vector weights: "+datapoint.classification.vector.weights.to_s
						datapoint.classification.vector.add feature_vectors[datapoint.url]
						Classification.find_by_name(classification).vector.subtract feature_vectors[datapoint.url]
					end
				end
			end
			classified_correctly = Array.new
			classified_incorrectly = Array.new
			Datapoint.all.each do |datapoint|
				if datapoint.classification.name == Classifier.classify_url(datapoint.url).max_by{|k,v| v}[0]
					classified_correctly << datapoint.url
				else
					classified_incorrectly << datapoint.url
				end
			end
			{"classified_correctly" => classified_correctly, "classified_incorrectly" => classified_incorrectly}
		end

		private :new
	end
end