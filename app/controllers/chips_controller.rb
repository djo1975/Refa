class ChipsController < ApplicationController
    skip_before_action :verify_authenticity_token


  def show
    player = Player.find(params[:id])
    render json: { player_id: player.id, chips: player.chips }
  end
  
    def add_chips
      player = Player.find(params[:id])
      chips_to_add = params[:chips].to_i
  
      player.chips += chips_to_add
      if player.save
        render json: { message: "Chips added successfully" }, status: :ok
      else
        render json: { errors: player.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def remove_chips
      player = Player.find(params[:id])
      chips_to_remove = params[:chips].to_i
  
      if player.chips >= chips_to_remove
        player.chips -= chips_to_remove
        if player.save
          render json: { message: "Chips removed successfully" }, status: :ok
        else
          render json: { errors: player.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: "Not enough chips to remove" }, status: :unprocessable_entity
      end
    end
    
    def refund_chips
      player = Player.find(params[:id])
      chips_to_refund = params[:chips].to_i
  
      player.chips += chips_to_refund
      if player.save
        render json: { message: "Chips refunded successfully" }, status: :ok
      else
        render json: { errors: player.errors.full_messages }, status: :unprocessable_entity
      end
    end
    
    
    
end