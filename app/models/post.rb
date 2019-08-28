class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :bookings
  has_many :reviews, through: :bookings
  include PgSearch::Model
  pg_search_scope :search,
    against: [ :title, :description ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
