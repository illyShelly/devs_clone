class Developer < ApplicationRecord
  belongs_to :user

  has_many :developer_skills, dependent: :destroy
  has_many :skills, through: :developer_skills
  has_many :projects
  has_many :bookings
end

# 1. relationships
# 2. validation
