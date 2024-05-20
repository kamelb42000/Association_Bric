class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :product


  validate :check_user_bookings_limit, on: :create

  private

  def check_user_bookings_limit
    if user.bookings.where(accepted: nil).count >= 2
      errors.add(:base, "Vous ne pouvez pas réserver plus de deux produits à la fois.")
    end
  end

end
