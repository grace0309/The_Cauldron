class BookingPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    record.post.user != user
  end

  def new?
    record.post.user != user
  end

  def update?
    true
  end

  def destroy?
    record.user == user
  end
end
