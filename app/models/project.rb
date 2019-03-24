class Project < ApplicationRecord
  belongs_to :developer

  default_scope { order(created_at: :asc) }
end
