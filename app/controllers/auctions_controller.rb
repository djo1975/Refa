# app/controllers/auctions_controller.rb
class AuctionsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :set_game

  # GET /games/:game_id/auctions
  def index
    @auctions = @game.auctions
    render json: @auctions
  end

    def create
      # Provera da li postoji aktivna aukcija za ovu igru i obrišite je ako postoji
      if Auction.exists?(game_id: params[:game_id])
        Auction.find_by(game_id: params[:game_id]).destroy
      end
  
      # Kreiranje nove aukcije
      @auction = Auction.new(game_id: params[:game_id], current_player_id: params[:current_player_id])
  
      if @auction.save
        render json: { message: 'Auction started successfully' }
      else
        render json: { error: 'Failed to start auction' }, status: :unprocessable_entity
      end
    end
  
    # Akcija za završetak aukcije
    def destroy
      @auction = Auction.find_by(game_id: params[:game_id])
  
      if @auction
        @auction.destroy
        render json: { message: 'Auction ended successfully' }
      else
        render json: { error: 'Auction not found' }, status: :not_found
      end
    end
  
    private

    def set_game
      @game = Game.find(params[:game_id])
    end
  end
  