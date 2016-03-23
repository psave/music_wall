class Favorite < ActiveRecord::Base

  validates :rating, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to:5, message: 'must be a number between 1 and 5'}

end