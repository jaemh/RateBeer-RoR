module RatingAverage
	extend ActiveSupport::Concern

	def average_rating
		sum = ratings.inject(0) { |sum, rating| sum + rating.score }
		return sum / ratings.count
	end
end