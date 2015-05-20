class Classifier
	class << self

  	def instance
			@instance ||= new
		end
		
		def classify_url(url)
			vector = FeatureVectorCreator.get_vector(url)
			class_outcomes = {}
			Classification.all.each do |classification|
				class_outcomes[classification.name] = classification.vector*vector
			end
			class_outcomes
		end

		private :new
	end
end