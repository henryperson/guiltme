class Vector < ActiveRecord::Base
  attr_accessible :weights, :classification
  serialize :weights
  has_one :classification
  after_initialize :initialize_weights

  def initialize_weights
  	unless self.weights
  		self.weights = []
  	end
  end

  def initialize_weights_for_classification
  	self.weights =  Array.new(FeatureVectorCreator.size) { 0 }
  	self.weights[0] = 1 #bias
  end

  def <<(element)
  	self.weights << element
  end

  def size
  	self.weights.size
  end

  def -(other)
  	vector = Vector.new
  		self.weights.zip(other.weights).each do |weight1, weight2|
  			vector << weight2 - weight1
  		end
  	vector
  end

  def +(other)
  	vector = Vector.new
  		self.weights.zip(other.weights).each do |weight1, weight2|
  			vector << weight2 + weight1
  		end
  	vector
  end

  def constant_mult(constant)
  	vector = Vector.new
  	self.weights.each do |weight|
  		vector << weight * 2
  	end
  	vector
  end

  def *(other)
  	sum = 0
  	self.weights.zip(other.weights).each do |weight1, weight2|
  		unless weight2
  			break
  		end
  		sum+=weight1*weight2
  	end
  	sum
  end

  def add(other)
  	other.weights.each_with_index do |weight, i|
  		if i < self.weights.size
  			self.weights[i] += weight
  		end
  	end
  	self.save
  end

  def subtract(other)
  	other.weights.each_with_index do |weight, i|
  		if i < self.weights.size
  			self.weights[i] -= weight
  		end
  	end
  	self.save
  end

end
