class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit

  # Ajouter un gestionnaire d'exception pour Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    # Définir le message d'erreur personnalisé
    flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
    redirect_to(request.referrer || root_path)
  end
end
