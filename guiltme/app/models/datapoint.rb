class Datapoint < ActiveRecord::Base
  attr_accessible :url
  belongs_to :classification
  # after_create :

  # def create(url, classification)

  # end
end
