class Brewery < ApplicationRecord
  include RatingAverage
  
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, presence: true,
                   length: { in: 3..30 }

  validates :year, numericality: { 
                   only_integer: true,
                   greater_than_or_equal_to: 1040,
                   less_than_or_equal_to: Date.today.year
                }
  
end
