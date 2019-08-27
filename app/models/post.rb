class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :bookings
  has_many :reviews

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
