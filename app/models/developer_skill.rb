class DeveloperSkill < ApplicationRecord
  belongs_to :developer
  belongs_to :skill

  validates :skill, uniqueness: { scope: :developer }
end

# 2 foreign keys auto added
