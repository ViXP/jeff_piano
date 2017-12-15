class Recording < ApplicationRecord
  # Associations
  has_many :recording_clips, dependent: :destroy
  has_many :clips, -> { distinct }, through: :recording_clips

  # Validations
  validates :title, presence: true, length: { minimum: 2 }

  def duration
    clips.last
  end
end
