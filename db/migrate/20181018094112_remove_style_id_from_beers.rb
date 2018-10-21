class RemoveStyleIdFromBeers < ActiveRecord::Migration[5.2]
  def change
    remove_column :beers, :style_id, :integer
  end
end
