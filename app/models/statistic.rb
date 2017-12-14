class Statistic
  def self.recordings_stats
    Recording.count
  end

  def self.distribution_stats
    ActiveRecord::Base.connection.execute('
      SELECT recording_clips.clip_id AS number, 
        (COUNT(recording_clips.clip_id) * 100 / overall.counter) AS distribution
      FROM recording_clips,
        (SELECT COUNT(*) AS counter FROM recording_clips) as overall
      GROUP BY clip_id, overall.counter
      ORDER BY clip_id ASC;
    ').to_a
  end

  def self.average_rate_stats

  end
end