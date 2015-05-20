class Classification < ActiveRecord::Base
  attr_accessible :name, :vector
  has_one :vector
  has_many :datapoints
  after_create :initialize_weight_vector
  validates_presence_of :name, :vector

  def self.find_or_new(name)
  	Classification.find_by_name(name) || Classification.new(:name => name)
  end

  def self.initialize_weight_vectors
  	Classification.all.each do |classification|
  		classification.initialize_weight_vector
  	end
  end

  # Currently only increases the size of the weight vector
  def resize_weight_vector
  	(FeatureVectorCreator.size - self.vector.size).times do |i|
  		self.vector << 0
  	end
  	self.vector.save
  end

  def self.resize_all_weight_vectors
  	Classification.all.each do |classification|
  		classification.resize_weight_vector
  	end
  end

  def initialize_weight_vector
  	self.vector = Vector.new
  end
end
