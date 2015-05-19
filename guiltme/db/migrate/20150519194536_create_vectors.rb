class CreateVectors < ActiveRecord::Migration
  def change
    create_table :vectors do |t|
      t.string :weights
      t.references :classification
      t.timestamps
    end
  end
end
