class PostPolicy < ApplicationPolicy
  def show?
    return true
  end

  def create?
    return true
  end

  def new?
    return true
  end

  def update?
    record.user == user
    # - record: the restaurant passed to the `authorize` method in controller
    # - user:   the `current_user` signed in with Devise.
  end

  def destroy?
    record.user == user
  end
end
