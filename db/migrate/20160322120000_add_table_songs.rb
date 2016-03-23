class AddTableSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.references(:artist)
      t.references(:user)
      t.string :title
      t.string :genre
      t.text :lyrics
      t.text :url
      t.timestamps
    end
  end

end