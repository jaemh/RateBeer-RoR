class DropProducts < ActiveRecord::Migration[5.2]
  def change
    drop_table :styles
  end
end
