# require 'hello'

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

		def f_count_meme(url)
			parsed_url = URI.parse(url)
			req = Net::HTTP.get(parsed_url)
			# req.scan("reddit")
			req.scan("www.reddit.com.r.")
		end


		private :new

		# All of the following methods will be features, done in alphabetical ordering. Include an 'f_' before each one.
		private
		def f_bias(url)
			1
		end

		# Hardcoded a laplace smoothing factor of 1 into both of these. Should always be > 0 to prevent divide by 0's but doesn't have to be an integer.
		def f_expectation_domain_name_is_work(url)
			DomainCounts.get_expectation(url, "work", 1)
		end

		def f_expectation_domain_name_is_procrastination(url)
			DomainCounts.get_expectation(url, "procrastination", 1)
		end

		
	end
end