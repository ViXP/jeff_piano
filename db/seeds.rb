Clip.destroy_all
Recording.destroy_all

c1 = Clip.create!(number: 1, duration: 0,
  url: 'https://d15t3vksqnhdeh.cloudfront.net/videos/1.mp4')
c2 = Clip.create!(number: 2, duration: 0,
  url: 'https://d15t3vksqnhdeh.cloudfront.net/videos/2.mp4')
c3 = Clip.create!(number: 3, duration: 0, 
  url: 'https://d15t3vksqnhdeh.cloudfront.net/videos/3.mp4')

r1 = Recording.create(title: 'First recording')
r2 = Recording.create(title: 'Second recording')
r3 = Recording.create(title: 'Third recording')

100.times do
  RecordingClip.create(
    recording: [r1, r2, r3].sample,
    clip: [c1, c2, c3].sample,
    start_time: rand(0..10_000)
  )
end