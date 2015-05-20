class ClassifiedHistory

	def classify(url_to_time_hash)
		@url_to_class_hash = {}
		url_to_time_hash.keys.each do |url|
			vector = FeatureVectorCreator.get_vector(url)
			class_outcomes = {}
			Classification.all.each do |classification|
				class_outcomes[classification.name] = classification.vector*vector
			end
			@url_to_class_hash[url]= class_outcomes.max_by{|k,v| v}[0]
		end
	end

	def as_json(options={})
		@url_to_class_hash.to_json
	end

end