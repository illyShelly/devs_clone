class DeveloperSkill < ApplicationRecord
  belongs_to :developer
  belongs_to :skill
end

# 2 foreign keys auto added
