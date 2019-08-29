class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :title, :description ],
    associated_against: {
      category: [ :category ]
    },
    using: {
      tsearch: { any_word: true }
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
