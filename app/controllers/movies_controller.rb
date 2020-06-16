class MoviesController < ApplicationController

  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

    def index
     @movies = Movie.send(movies_filter)
    end 

    def show

        # @movie = Movie.find_by!(slug: params[:id])
        @fans = @movie.fans
        @genres = @movie.genres
        if current_user
        @favorite = current_user.favorites.find_by(movie_id: @movie.id)
  end
        
    end

    def edit
     
    end

    def update
        
         if @movie.update(movie_params)
            title = movie_params[:title]
            redirect_to @movie, notice: "#{title} was succesfully updated!"
         else
            render :edit
         end 
    end

    def new 

        @movie = Movie.new
    end 
          

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        title = movie_params[:title]
        redirect_to @movie, notice: "#{title} was successfully created!"
      else 
        render :new
      end 
    end

    def destroy 
        @movie.destroy
        title = @movie.title
        redirect_to movies_path, alert: "#{title} was successfully deleted"
    end

    

     private
      def movie_params
       params.require(:movie).permit(:title, :description, :rating, :released_on,:main_image ,:total_gross, :director, :duration, genre_ids:[])     
      end
      def review_params
            params.require(:review).permit(:name, :comment, :stars)
        end

      def movies_filter
        if params[:filter].in? %w(upcoming recent hits flops)
          params[:filter]
        else
          :released
        end
      end
      def set_movie
        @movie = Movie.find_by!(slug: params[:id])
      end
      
end

