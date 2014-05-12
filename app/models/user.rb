class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable.
  # Removed :trackable, :recoverable from default modules. /A

  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  # Devise takes care of validation rules (can be found in config)
  # Devise also stores the controller.

  has_many :owned_groups, class_name: 'Group', foreign_key: :owner_id
  has_and_belongs_to_many :group
  has_and_belongs_to_many :voted_for, class_name: 'Activity', join_table: :votes
end
