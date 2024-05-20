class Member < ApplicationRecord
  has_one_attached :photo
  has_many :services

  validates :first_name, :last_name, :address, :phone_number, :email, :membership_number, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, format: { with: /\A\d{10}\z/, message: "doit être un numéro à 10 chiffres" }
  validates :membership_number, numericality: { only_integer: true }
end
