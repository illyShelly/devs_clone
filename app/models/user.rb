class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile
  has_many :bookmarks
  has_many :bookmarked_developers, through: :bookmarks, source: :bookmarked, source_type: 'Developer'

  def bookmarked?(developer)
    bookmarked_developers.any? { |booked_dev| booked_dev.id == developer.id }
  end

  def has_profile?
    profile.present?
  end
end
