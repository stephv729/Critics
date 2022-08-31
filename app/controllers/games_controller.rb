class GamesController < ApplicationController
  def index
    @games = Game.all
    @role = current_user.nil? ? "regular" : current_user.role
    @id = current_user.nil? ? nil : current_user.id
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      redirect_to games_path # /games
    else
      render "new", status: :unprocessable_entity
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to games_path
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path, status: :see_other
  end

  def delete_data
    game = Game.find(params[:id])
    platform = Platform.find(params[:platform_id]) if params[:platform_id]
    genre = Genre.find(params[:genre_id]) if params[:genre_id]
    developer = InvolvedCompany.find(params[:d_id]) if params[:d_id]
    publisher = InvolvedCompany.find(params[:p_id]) if params[:p_id]
    # publisher = InvolvedCompany.find_by(game:game, company:)
    game.platforms.delete(platform) if platform
    game.genres.delete(genre) if genre
    developer.update(developer:false) if developer
    publisher.update(publisher:false) if publisher
  
    redirect_to game  # game solo es igual a game_path(game) que es la vista del show(default)
  end

  def update_data
    game = Game.find(params[:game_id])
    if params[:genre].present?
      game.genres << Genre.find(params[:genre])
    elsif params[:platform].present?
      game.platforms << Platform.find(params[:platform])
    elsif params[:developer].present?
      puts "-"*20
      company = Company.find(params[:developer])
      # el find_or_create_by - Es buscarlo y si no lo encuentra lo crea.
      developer = InvolvedCompany.find_or_create_by(game: game, company: company)
      developer.update(developer:true)
    elsif params[:publisher].present?
      company = Company.find(params[:publisher])
      publisher = InvolvedCompany.find_or_create_by(game:game,company:company)
      publisher.update(publisher:true)
    end
    redirect_to game_path(id: params[:game_id])
  end

  def critics
    @game = Game.find(params[:id])
    @errors = params[:errors]
  end

  private

  def game_params
    params.require(:game).permit(:name, :summary, :release_date, :category, :rating, :cover,
                                 :parent_id)
  end
end
