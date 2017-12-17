#json.array! clips, partial: 'clips/clip', as: :clip
clips.each do |clip|
  json.partial! clip
end