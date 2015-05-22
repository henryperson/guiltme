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

  def *(other)
  	sum = 0
  	self.weights.zip(other.weights).each do |weight1, weight2|
  		sum+=weight1*weight2
  	end
  	sum
  end

  def add(other)
  	other.weights.each_with_index do |weight, i|
  		self.weights[i] -= weight
  	end
  	self.save
  end

  def subtract(other)
  	other.weights.each_with_index do |weight, i|
  		self.weights[i] += weight
  	end
  	self.save
  end

end
