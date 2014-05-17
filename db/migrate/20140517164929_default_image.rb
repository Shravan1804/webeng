class DefaultImage < ActiveRecord::Migration
  def change
	change_column :activities, :image, :string, :default => "http://placehold.it/150x150"
  end
end
