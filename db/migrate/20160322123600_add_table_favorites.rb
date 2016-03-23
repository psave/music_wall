class AddTableFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references(:song)
      t.references(:user)
      t.integer :rating
      t.timestamps
    end
  end

end