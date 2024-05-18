class BookingPolicy < ApplicationPolicy
  def accept?
    user.admin?
  end

  def refuse?
    user.admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
