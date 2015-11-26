class ReviewsController < ApplicationController

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create

    restaurant = Restaurant.find(params[:restaurant_id])
    @review = restaurant.build_review(review_params, current_user)
    # @review = Review.build_review review_params, current_user, restaurant
    if @review.save
      redirect_to restaurants_path
    else
      if @review.errors[:user]
        redirect_to restaurants_path, alert: "You have already reviewed this restaurant"
      else
        render :new
      end
    end
  end

  # def build_review(review_params, current_user)
  #   @review = Review.new(review_params)
  #   @review.user_id = current_user.id
  # end

  def review_params
    params.require(:review).permit(:thoughts, :rating, :restaurant_id)
  end
end
