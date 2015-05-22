class Datapoint < ActiveRecord::Base
  attr_accessible :url, :classification
  belongs_to :classification
  validates_presence_of :classification, :url
  validates_uniqueness_of :url

  def self.new_or_overwrite(url, classification)
  	old_datapoint = Datapoint.find_by_url(url)
  	old_classification = nil
  	if old_datapoint
  		old_classification = old_datapoint.classification
  	end
  	datapoint = old_datapoint || Datapoint.new(:url => url)
  	datapoint.classification = classification
  	datapoint.save
  	DomainCounts.update_counts(datapoint, old_classification)
  	datapoint
  end

end
