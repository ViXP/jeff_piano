class RecordingClip < ApplicationRecord
  # Attributes
  self.primary_keys = :recording_id, :clip_id, :start_time

  # Associations
  belongs_to :recording
  belongs_to :clip

  # Validations
  validates :start_time, presence: true, numericality: { only_integer: true,
    greater_than: 0 }

  # Scopes
  default_scope { order(start_time: :asc) }

  def number=(number)
    self.clip_id = number
  end
end
