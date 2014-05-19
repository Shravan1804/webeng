class AddDefinitiveToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :definitive, :boolean, default: false
  end
end
