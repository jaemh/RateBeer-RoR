module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    s = ratings.reduce(0.0) { |sum, r| sum + r.score }
    s / r.count
  end
end
