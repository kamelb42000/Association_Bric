class Member < ApplicationRecord
  has_one_attached :photo

  # Add validations and other model logic
  validates :date, presence: true
end
