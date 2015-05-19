class FeatureVectorCreator
	class << self

		def instance
			@instance ||= new
		end

		def size
			self.feature_functions.size
		end

		def get_vector(datapoint)
			feature_vector = Vector.new
			@@FEATURE_FUNCTIONS.each do |f|
				feature_vector << f(datapoint)
			end
			feature_vector
		end

		def feature_functions
			self.singleton_methods.select {|f| f.to_s.include? 'f_'}
		end

		private :new

		# All of the following methods will be features. Include an 'f_' before each one.
		private

		def f_bias(datapoint)
			1
		end

		
	end
end