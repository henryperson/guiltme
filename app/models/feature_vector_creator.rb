class FeatureVectorCreator
  class << self

    def instance
      @instance ||= new
    end

    def feature_functions
      self.private_methods.select {|f| f.to_s.start_with? 'f_'}.sort_by { |f| f.to_s }
    end

    def size
      feature_functions.size
    end

    def get_vector(url, laplace_factor = 1)
      feature_vector = Vector.new
      feature_functions.each do |f|
        feature_vector << self.send(f,url, laplace_factor)
      end
      feature_vector
    end

    def has_bias?
      bias_position != -1
    end

    def bias_position
      functions = feature_functions
      unless functions.select {|f| f.to_s.include? 'bias'}.any?
        return false
      end
      functions.each_index.select{|i| functions[i].to_s.include? 'bias'}.first
    end

    private :new

    # All of the following methods will be features, done in alphabetical ordering. Include an 'f_' before each one.
    private
    def f_bias(url, laplace_factor)
      1
    end

    def f_expectation_domain_name_is_work(url, laplace_factor)
      DomainCounts.get_expectation(url, "work", laplace_factor)
    end

    def f_expectation_domain_name_is_procrastination(url, laplace_factor)
      DomainCounts.get_expectation(url, "procrastination", laplace_factor)
    end

  end
end