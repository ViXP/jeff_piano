class Recording < ApplicationRecord
  # Associations
  has_many :recording_clips, dependent: destroy
  has_many :clips, -> { distinct }, through: :recording_clips
end
