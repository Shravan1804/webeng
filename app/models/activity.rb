class Activity < ActiveRecord::Base

  validates :name, presence: true, length: { in: 6..30 }
  validates :location, presence: true, length: { in: 3..20 }
  validates :start_date, presence: true
  validates :description, presence: true, length: { in: 6..400 }
  validates :image, presence: true

  belongs_to :group
  has_and_belongs_to_many :voters, class_name: 'User', join_table: :votes
end
