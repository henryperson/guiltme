class FeatureVectorCreator
	class << self

		# Current problem – these don't specify an order, so adding new features is fine (we just add
		# more weights to each vector) but removing them gets tricky because we don't know what cell
		# every feature corresponds to in a weight vector.
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

		def f_bias(url)

		end

		
	end
end