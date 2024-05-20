class BookingPolicy < ApplicationPolicy
  def accept?
    user.admin? || record.user == user
  end

  def refuse?
    user.admin? || record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
