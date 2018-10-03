class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships
 

  validates :username, uniqueness: true,
  length: { minimum: 3 }

  validates :password, length: { minimum: 4},
                       format: { with: /(?=.*[A-Z])./, 
                       message: "must include at least one one uppercase letter"}


  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer 
  end

  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
  end
  
  end
end

