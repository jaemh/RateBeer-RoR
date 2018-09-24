class CreateBeerClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :beer_clubs do |t|
      t.Integer, :founded
      t.String :city

      t.timestamps
    end
  end
end
