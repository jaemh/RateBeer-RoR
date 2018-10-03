class CreateStyles < ActiveRecord::Migration[5.2]
  def change
    create_table :styles do |t|
      t.string :name
      t.integer :style_id
      t.integer :beer_id

      t.timestamps
    end
  end
end
