class User < ApplicationRecord
  include RatingAverage

  has_secure_password
  
  has_many :ratings
  has_many :beers, through: :ratings
  has_many :beer_clubs, through: :memberships
 

  validates :username, uniqueness: true,
  length: { minimum: 3 }

  validates :password, length: { minimum: 4},
                       format: { with: /(?=.*[A-Z])./, 
                       message: "must include at least one one uppercase letter"}

end

