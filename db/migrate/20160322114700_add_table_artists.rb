class AddTableArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.references(:user)
      t.string :name
      t.timestamps
    end
  end

end