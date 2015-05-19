class Classification < ActiveRecord::Base
  attr_accessible :name
  has_one :vector
  has_many :datapoints
  after_initialize :initialize_weight_vector
  validates_presence_of :name

  def initialize_weight_vector
  	self.vector = Vector.new
  	self.vector.classification = self
  end
end
