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
                       message: "must include at least one one uppercase letter"
                }
  
  scope :active, -> { where active: true }
  scope :locked, -> { where active: [nil,false] }

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer 
  end

  def create_beers_with_many_ratings(object, *scores)
    scores.each do |score|
      create_beer_with_rating(object, score)
  end
  end

  def favorite_style
    favorite(:style)
  end

  def favorite_brewery
    favorite(:brewery)
  end

  def favorite(groupped_by)
    return nil if ratings.empty?

    grouped_ratings = ratings.group_by{ |r| r.beer.send(groupped_by) }
    averages = grouped_ratings.map do |group, ratings|
      { group: group, score: average_of(ratings) }
    end

    averages.max_by{ |r| r[:score] }[:group]
  end

  def self.top(how_many)
    sorted_by_rating_in_desc_order = all.sort_by{ |u| -u.ratings.count }
    sorted_by_rating_in_desc_order[0, how_many]
  end
end

