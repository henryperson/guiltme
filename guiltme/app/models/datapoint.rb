class Datapoint < ActiveRecord::Base
  attr_accessible :url, :classification
  belongs_to :classification
  validates_presence_of :classification, :url
  validates_uniqueness_of :url

end
