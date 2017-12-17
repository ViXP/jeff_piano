json.extract! recording, :id, :title, :created_at
json.clips(recording.recording_clips) do |clip|
  json.number clip.clip_id
  json.start_time clip.start_time
end