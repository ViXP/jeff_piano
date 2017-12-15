module DurationCountable
  extend ActiveSupport::Concern

  included do
    default_scope { 
      joins(format(
        <<-SQL
          LEFT JOIN
            (SELECT %{recording_clips}.recording_id, 
              (%{recording_clips}.start_time + %{clips}.duration) AS duration
            FROM %{recording_clips}
            INNER JOIN
              (SELECT recording_id, MAX(start_time) AS start_time
              FROM %{recording_clips}
              GROUP BY recording_id) as table2
            ON %{recording_clips}.recording_id = table2.recording_id
            AND %{recording_clips}.start_time = table2.start_time
            INNER JOIN %{clips}
            ON %{recording_clips}.clip_id = %{clips}.number) AS final_table
          ON recordings.id = final_table.recording_id
        SQL
        .gsub(/\s/, ' '), { recording_clips: RecordingClip.table_name,
          clips: Clip.table_name, recordings: Recording.table_name }
        )
      ).select('*') 
    }
  end

  def duration
    (read_attribute(:duration).to_f / 1000).round(2)
  end
end
