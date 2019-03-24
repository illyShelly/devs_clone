class Developer < ApplicationRecord
  belongs_to :user

  has_many :developer_skills, dependent: :destroy
  has_many :skills, through: :developer_skills
  has_many :projects
  has_many :bookings

  validates :first_name, :last_name, :skills, :github_username, presence: true
  validates :bio, presence: true, length: { minimum: 44 }

  default_scope { order(hourly_rate: :desc) }

  def full_name
    "#{first_name} #{last_name}"
  end

  def skills_to_string
    # skills.pluck(:name).map(&:titleize).join(" | ")
    skills.pluck(:name).map { |skill| skill.titleize }.join(" | ")
  end

  # top devs on homepage
  def self.top_devs
    Developer.order(hourly_rate: :desc).limit(3)
  end
end

# 1. relationships
# 2. validation

# pluck(*column_names) public
# Use pluck as a shortcut to SELECT ONE OR MORE ATTRIBUTES without loading a bunch of records just to grab the attributes you want.
# Person.pluck(:name) vs. Person.all.map(&:name)

# titleize(word) public
# Capitalizes all the words and REPLACES SOME CHARACTERS in the string to create a nicer looking title - as titlecase.
# 'man from the boondocks'.titleize   # => "Man From The Boondocks"

# Turns the symbol into a simple proc &:
# The same as people.collect { |p| p.name } -> people.collect(&:name)

# The same as people.select { |p| p.manager? }.collect { |p| p.salary }
# people.select(&:manager?).collect(&:salary)
