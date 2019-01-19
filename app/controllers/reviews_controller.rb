class ReviewsController < ApplicationController
  before_filter :set_user_variable, except: [:sign_in, :login]

  def set_user_variable
    @user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.build(rating: params[:review][:rating], description: params[:review][:description], product_id: params[:review][:product_id])
    @review.user = current_user
    
    if current_user
      @review.product_id = @product.id
      @review.user_id = current_user.id
      if @review.valid?
        flash[:notice] = 'Review was successfully created.'
        @review.save!
      else
        flash[:notice] = "Error creating review: #{@review.errors}"
      end
    end
    
    redirect_to @product
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to :back
  end
end
