class MIRALearner < Learner
  class << self

  	def instance
			@instance ||= new
		end
		
		def learn

		end

		private :new
	end
end
