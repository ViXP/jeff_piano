class Recording < ApplicationRecord
  include DurationCountable

  # Associations
  has_many :recording_clips, dependent: :destroy
  has_many :clips, through: :recording_clips

  # Validations
  validates :title, presence: true, length: { minimum: 2 }
end
