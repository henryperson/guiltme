class ClassifiedHistory

  # Perceptron-based classification – can change later to K-NN or Bayes Net (perhaps as a meta variable)
  def classify(urls)
    @urls = urls
    @url_to_class_hash = {}
    urls.each do |url|
      @url_to_class_hash[url]= Classifier.classify_url(url)
    end
  end

  def as_json(options={})
    @url_to_class_hash
  end

end