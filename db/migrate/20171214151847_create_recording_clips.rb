class CreateRecordingClips < ActiveRecord::Migration[5.1]
  def change
    create_table :recording_clips, id: false do |t|
      t.integer :recording_id, foreign_key: true
      t.integer :clip_id, null: false
      t.bigint :start_time, null: false
    end
    
    add_foreign_key :recording_clips, :clips, column: :clip_id,
      primary_key: 'number'
    
    execute 'ALTER TABLE recording_clips ADD PRIMARY KEY(recording_id, ' \
      'clip_id, start_time)';
  end
end
