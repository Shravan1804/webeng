class Activity < ActiveRecord::Base

  validates :name, presence: true, length: { in: 3..30 }
  validates :location, presence: true, length: { in: 3..20 }
  validates :start_date, presence: true
  validates :duration, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :description, presence: true, length: { in: 6..1000 }

  belongs_to :group
  has_and_belongs_to_many :voters, class_name: 'User', join_table: :votes
end
