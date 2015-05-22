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

		def get_vector(url)
			feature_vector = Vector.new
			feature_functions.each do |f|
				feature_vector << self.send(f,url)
			end
			feature_vector
		end

		private :new

		# All of the following methods will be features, done in alphabetical ordering. Include an 'f_#_' before each one.
		private
		def f_1_bias(url)
			1
		end

		def f_2_expectation_domain_name_is_work(url)
			DomainCounts.get_expectation(url, "work", 0)
		end

		def f_3_expectation_domain_name_is_procrastination(url)
			DomainCounts.get_expectation(url, "procrastination", 0)
		end

	end
end