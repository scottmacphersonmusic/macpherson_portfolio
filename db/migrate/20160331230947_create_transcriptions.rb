class CreateTranscriptions < ActiveRecord::Migration
  def change
    create_table :transcriptions do |t|
      t.string :song_title
      t.string :soloist_first_name
      t.string :soloist_last_name
      t.string :pdf
      t.string :mp3

      t.timestamps null: false
    end
  end
end
