class Review < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :user
  validates :rating, inclusion:(1..5)
  validates :user, uniqueness: { scope: :restaurant, message: "has reviewed this message already"}


   def self.build_review(review_params, current_user, restaurant)
    new(review_params.merge({user: current_user}))
  end
end
