class RecordingClip < ApplicationRecord
  self.primary_keys = %i[recording_id, clip_id, start_time]

  # Associations
  belongs_to :recordings
  belongs_to :clips
end
