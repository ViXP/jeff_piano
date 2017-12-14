class RecordingClip < ApplicationRecord
  self.primary_keys = :recording_id, :clip_id, :start_time

  # Associations
  belongs_to :recording
  belongs_to :clip
end
