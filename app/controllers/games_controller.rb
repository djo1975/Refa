class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    games = Game.all
    render json: games
  end

  def create
    num_buli = params[:buli].to_i
    ref_count = params[:ref_count].to_i
  
    player1_id = params[:player1_id]
    player2_id = params[:player2_id]
    player3_id = params[:player3_id]
  
    player1 = Player.find(player1_id)
  
    if player1.active_game?
      render json: { errors: 'Player 1 already has an active game' }, status: :unprocessable_entity
      return
    end
  
    @game = Game.new(
      creator_id: player1_id,
      player2_id: player2_id,
      player3_id: player3_id,
      buli: num_buli,
      ref_count: ref_count,
      status: 'pending'
    )  

    @game.players << Player.find(player2_id) if player2_id.present?
    @game.players << Player.find(player3_id) if player3_id.present?

    if @game.save
      if @game.full?
        redirect_to play_game_path(@game)
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
        redirect_to play_game_path(@game)
      else
        render json: { message: 'Player 2 joined the game successfully' }, status: :ok
      end
    else
      render json: { errors: @game.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def join
    @game = Game.find(params[:id])
    player_id = params[:player_id]
    
    if @game.status == 'pending' && !@game.full?
      @game.update(player3_id: player_id)
      @game.update(status: 'active')
      
      render json: { message: 'Player 3 joined the game successfully', game: @game }, status: :ok
    else
      render json: { errors: 'Game cannot be joined at this time' }, status: :unprocessable_entity
    end
  end
  
  def play
    @game = Game.find(params[:id])
    # Add any necessary logic for playing the game
    
    render json: { message: 'Game is now active and being played', game: @game }, status: :ok
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
