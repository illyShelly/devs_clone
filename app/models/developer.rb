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

  # array of hashes
  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      # as a hash
      {
        from: range[0],
        to: range[1]
      }
    end
  end
end

# date_string = array[0][:from] = Wed, 27 Mar 2019...
# #  # date_string.class = Date
# #  date_string.strftime('%F') = "2019-03-27"

# @booking
# => #<Booking id: 9, start_date: "2019-03-30", end_date: "2019-04-01", user_id: 1, developer_id: 4, created_at: "2019-03-26 20:22:18", updated_at: "2019-03-26 20:22:18">

# >>  @developer
# => #<Developer id: 4, first_name: "TJ", last_name: " Holowaychuk", github_username: "tj", avatar_url: "https://avatars2.githubusercontent.com/u/25254?s=4...", bio: "Founder of Apex\r\nhttps://apex.sh, a non-startup.\r\n...", hourly_rate: 390, bookings_count: 2, user_id: 1, created_at: "2019-03-26 13:46:14", updated_at: "2019-03-26 13:46:14">
# >>  @developer.unavailable_dates
# => [{:from=>Wed, 27 Mar 2019, :to=>Thu, 28 Mar 2019}, {:from=>Sat, 30 Mar 2019, :to=>Mon, 01 Apr 2019}]
# >>

# need our backend to send to the front-end a LIST of all the UNAVAILABLE DATES. Accordingly to flatpickr’s documentation, it is possible to pass an OPTION to DISABLE DATES as an ARRAY of RANGES of dates [{ from: "2018-05-01, to: "2018-05-20"}]. Let’s add a method unavailable_dates to our Developer model

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
