class AddTableFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references(:songs)
      t.references(:users)
      t.integer :rating
      t.timestamps
    end
  end

end