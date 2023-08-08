class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    all_games = Game.all
    render json: all_games
  end

  def create
    num_buli = params[:buli].to_i
    ref_count = params[:ref_count].to_i

    player1_id = params[:player1_id]
    player2_id = params[:player2_id]
    player3_id = params[:player3_id]

    if Player.find(player1_id).active_game?
      render json: { errors: 'Player 1 already has an active game' }, status: :unprocessable_entity
      return
    end

    @game = Game.new(
      creator_id: player1_id,
      player2_id:,
      player3_id:,
      buli: num_buli,
      ref_count:,
      status: 'pending'
    )

    @game.players << Player.find(player2_id) if player2_id.present?
    @game.players << Player.find(player3_id) if player3_id.present?

    if @game.save
      if @game.full?
        render json: { message: 'Game is now active' }, status: :ok
        else
        render json: @game, status: :created
      end
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @game = Game.find(params[:id])
  
    if @game.update(game_params)
      if @game.full?
        @game.update(status: 'active')
        render json: { message: 'Game is now active' }, status: :ok
            else
        player2_id = params[:player2_id]
        player3_id = params[:player3_id]
  
        if player2_id.present?
          player2 = Player.find(player2_id)
          if player2.chips >= @game.buli
            @game.players << player2 unless @game.players.include?(player2)
          else
            render json: { errors: 'Not enough chips for Player 2 to join the game' }, status: :unprocessable_entity
            return
          end
        end
  
        if player3_id.present?
          player3 = Player.find(player3_id)
          if player3.chips >= @game.buli
            @game.players << player3 unless @game.players.include?(player3)
          else
            render json: { errors: 'Not enough chips for Player 3 to join the game' }, status: :unprocessable_entity
            return
          end
        end
  
        render json: @game, status: :ok
      end
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    render json: { message: 'Game deleted successfully' }, status: :ok
  end

  private

  def game_params
    params.require(:game).permit(:buli, :ref_count, :player1_id, :player2_id, :player3_id)
  end
end
