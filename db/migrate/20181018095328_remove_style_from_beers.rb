class RemoveStyleFromBeers < ActiveRecord::Migration[5.2]
  def change
    remove_column :beers, :style, :integer
  end
end
