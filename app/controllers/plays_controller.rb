class PlaysController < ApplicationController
    def play
      @game = Game.find(params[:game_id])
      @player = Player.find(params[:player_id])
      
      # Implement your logic for player's move here
      
      # Update game status, player's hand, talon, etc.
      
      # Save changes to models
      @game.save
      @player.save
      
      render json: { message: 'Move played successfully' }
    end
  end
  