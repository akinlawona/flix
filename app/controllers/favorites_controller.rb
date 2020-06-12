class FavoritesController < ApplicationController
      before_action :require_signin
      before_action :set_movie
def create
 
  @movie.favorites.create!(user: current_user)
  redirect_to @movie, notice: "Succcessfully Added #{@movie.title} To Your Favorites"
end

def destroy
  favorite = current_user.favorites.find(params[:id])
  favorite.destroy
  redirect_to @movie, alert: "Succcessfully Removed #{@movie.title} From Your Favorites"    
end
private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

end
