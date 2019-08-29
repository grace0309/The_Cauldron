class ReviewPolicy < ApplicationPolicy
  def create?
    record.booking.user == user
  end

  def new?
    record.booking.user == user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
