class Statistic
  def self.recordings_stats
    Recording.count
  end

  def self.distribution_stats
    ActiveRecord::Base.connection.execute(
      <<~SQL.gsub(/\s/, ' ')
        SELECT recording_clips.clip_id AS number,
          (COUNT(recording_clips.clip_id) * 100 / counter.count) AS distribution
        FROM recording_clips,
          (SELECT COUNT(*) FROM recording_clips) as counter
        GROUP BY clip_id, counter.count
        ORDER BY clip_id ASC;
      SQL
    ).to_a
  end

  def self.average_rate_stats
    (Recording.with_duration.sum(:duration).to_f / 1000 / Clip.count).round(2)
  end
end
