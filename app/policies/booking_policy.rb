class BookingPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def create?
    record.post.user != user
  end

  def new?
    record.post.user != user
  end

  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
