class FeatureVectorCreator
	class << self
		@@FEATURE_FUNCTIONS = self.singleton_methods.select {|f| f.to_s.include? 'f_'}

		def instance
			@instance ||= new
		end

		def size
			@@FEATURE_FUNCTIONS.size
		end

		def get_vector(url)
			feature_vector = Vector.new
			@@FEATURE_FUNCTIONS.each do |f|
				feature_vector << f(url)
			end
			feature_vector
		end

		
		private :new

		# All of the following methods will be features. Include an 'f_' before each one.
		private
		def f_bias(url)
			1
		end

		
	end
end