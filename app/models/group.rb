class Group < ActiveRecord::Base
  validates :name, presence: true, length: { in: 6..30 }
  validates :date_created, presence: true
  validates :hometown, presence: true, length: { in: 6..30 }

  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :user
  has_many :activity
end
