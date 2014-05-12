class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :location
      t.datetime :start_date
      t.integer :duration
      t.string :description
      t.string :image
      t.integer :group_id

      t.timestamps
    end
  end
end
