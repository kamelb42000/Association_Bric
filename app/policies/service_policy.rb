class ServicePolicy < ApplicationPolicy
  def validate?
    user.admin? # Autoriser uniquement les administrateurs à valider
  end

  def accept?
    user.admin?  # Autoriser uniquement les administrateurs à accepter
  end

  def refuse?
    user.admin?  # Autoriser uniquement les administrateurs à refuser
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
