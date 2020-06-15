class GenresController < ApplicationController
  before_action :require_signin, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
    def index
        @genres = Genre.all
    end

    def show
        @genre = Genre.find(params[:id])

    end

    def new

        @genre = Genre.new
        
    end

    def edit 
         @genre = Genre.find(params[:id])     
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
        @genre = Genre.find(params[:id])

        if @genre.update(genre_params)
            name = genre_params[:name]
            redirect_to genre_path, notice:"#{name} was successfully updated"

        else 
            render :new 
        end 
    end

    def destroy
        @genre = Genre.find(params[:id])
        name = @genre.name
        @genre.destroy
        redirect_to genres_path, alert:"#{name} was successfully deleted!"
        
    end

    private 
    def genre_params
        params.require(:genre).permit(:name)
    end



end
