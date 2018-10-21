class RatingsController < ApplicationController
  def index
    @ratings = Rating.all

    respond_to do |format|
      format.html { } # renderöidään oletusarvoinen template
      format.json { render json: @ratings }
    end
  end

  def new
    @beers = Beer.all
    @rating = Rating.new
  end

  def show
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    @rating.user = current_user
    
    if current_user.nil?
      redirect_to signin_path, notice: 'You should be signed in!'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end 
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end

end
