class CreateClips < ActiveRecord::Migration[5.1]
  def change
    create_table :clips, id: false do |t|
      t.integer :number, null: false
      t.string :url, null: false
      t.bigint :duration, null: false
    end
    add_index :clips, :number, unique: true
    add_index :clips, :url, unique: true
  end
end
