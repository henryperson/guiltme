class CreateDatapoints < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.string :url
      t.references :classification
      t.timestamps
    end
  end
end
