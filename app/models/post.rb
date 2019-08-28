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


  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def unavailable_dates
   dates_array = self.bookings.pluck(:start_date, :end_date)
   dates = dates_array.map do |range|
      { from: range[0], to: range[1] }
    end
  end
end
