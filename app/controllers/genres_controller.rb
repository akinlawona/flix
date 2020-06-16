class GenresController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_genre, only: [:show, :edit, :destroy]
    def index
        @genres = Genre.all
    end

    def show
       

    end

    def new

        @genre = Genre.new
        
    end

    def edit 
           
    end

    def create
        @genre = Genre.new(genre_params)
         if @genre.save
        name = genre_params[:name]
        redirect_to @genre, notice: "#{name} was successfully created!"
      else 
        render :new
      end 
        
    end

    def update
        @genre = Genre.find_by!(slug: params[:id])

        if @genre.update(genre_params)
            name = genre_params[:name]
            redirect_to @genre, notice:"#{name} was successfully updated"

        else 
            render :new 
        end 
    end

    def destroy
     
        name = @genre.name
        @genre.destroy
        redirect_to genres_path, alert:"#{name} was successfully deleted!"
        
    end

    private 
    def genre_params
        params.require(:genre).permit(:name)
    end
    def set_genre
        @genre = Genre.find_by!(slug: params[:id])
    end



end
