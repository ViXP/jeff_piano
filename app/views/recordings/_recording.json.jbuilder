json.extract! recording, :id, :title, :created_at
json.clips do
  json.array! recording.recording_clips, :clip_id, :start_time  
end