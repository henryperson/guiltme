class ClassifiedHistory

	# Perceptron-based classification – can change later to K-NN or Bayes Net (perhaps as a meta variable)
	def classify(url_to_time_hash)
		@url_to_time_hash = url_to_time_hash
		@url_to_class_hash = {}
		url_to_time_hash.keys.each do |url|
			@url_to_class_hash[url]= Classifier.classify_url(url)
		end
	end

	def as_json(options={})
		classifications_to_times_and_urls = {}
		classifications_to_urls = @url_to_class_hash.each_with_object( {} ) { |(key, value), out| ( out[value] ||= [] ) << key }
		classifications_to_urls.keys.each do |classification|
			sum = 0
			classifications_to_urls[classification].each do |url|
				sum += @url_to_time_hash[url]
			end
			classifications_to_times_and_urls[classification] = {'time' => sum, 'urls' => classifications_to_urls[classification]}
		end
		classifications_to_times_and_urls
	end

end