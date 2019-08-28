class Booking < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true
  before_save :set_total_price

  def set_total_price
    startdate = self.start_date
    enddate = self.end_date
    daydiff = ((enddate - startdate) / 86400) + 1
    self.total_price = daydiff * self.post.price
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?
    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
