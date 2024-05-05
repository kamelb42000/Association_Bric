class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :product

  private

  def user_cannot_be_owner
    if user == product.user
      errors.add(:user, "le propriétaire du produit ne peut pas le réservé")
    end
  end

  def user_only_booked_one_product
    if user.bookings.any?
      errors.add(:user, "l'utilisateur ne peut réserver qu'un produit à la fois")
    end
  end

  def user_can_book_again
    if user.bookings.accepted.any?
      errors.add(:user, "l'utilisateur ne peut réserver un nouveau produit tant que sa réservation actuelle est acceptée")
    end
  end

end
