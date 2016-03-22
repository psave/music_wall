class AddTableSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.references(:artists)
      t.string :title
      t.string :genre
      t.text :lyrics
      t.timestamps
    end
  end

end