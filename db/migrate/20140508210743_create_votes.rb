class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes, id: false do |t|
      t.integer :user_id
      t.integer :activity_id
    end
  end
end