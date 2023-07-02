# players_controller.rb
class PlayersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    players = Player.all
    render json: players
  end

  def create
    player = Player.new(player_params)

    if player.save
      render json: player, status: :created
    else
      render json: player.errors, status: :unprocessable_entity
    end
  end

  def join_game
    player = Player.find(params[:id])
    game = Game.find(params[:game_id])

    if game.pending? && !game.full?
      game.players << player unless game.players.include?(player)
      render json: game, status: :ok
    else
      render json: { errors: 'Invalid game or game is full' }, status: :unprocessable_entity
    end
  end

  def leave_game
    player = Player.find(params[:id])
    game = Game.find(params[:game_id])

    if game.active? && game.players.include?(player)
      game.players.delete(player)
      render json: { message: 'Player left the game' }, status: :ok
    else
      render json: { errors: 'Invalid game or player is not in the game' }, status: :unprocessable_entity
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :picture, :email, :infractions, :chips, :rating)
  end
end
