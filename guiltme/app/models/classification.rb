class Classification < ActiveRecord::Base
  attr_accessible :name, :vector
  has_one :vector
  has_many :datapoints
  after_create :initialize_weight_vector
  validates_presence_of :name, :vector

  def self.find_or_new(name)
  	Classification.find_by_name(name) || Classification.new(:name => name)
  end

  def initialize_weight_vector
  	self.vector = Vector.new
  end
end
