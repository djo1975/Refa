class DealtCardsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_game

  def index
    # Pretražite DealtCard za odgovarajući game_id
    dealt_cards = DealtCard.where(game_id: params[:game_id]).first
  
    if dealt_cards
      render json: {
        game_id: dealt_cards.game_id,
        player1: dealt_cards.player1,
        player2: dealt_cards.player2,
        player3: dealt_cards.player3,
        table: dealt_cards.table,
        created_at: dealt_cards.created_at,
        updated_at: dealt_cards.updated_at
      }, status: :ok
    else
      render json: { message: 'Dealt cards not found' }, status: :not_found
    end
  end
  
  

  def create
    game = Game.find(params[:game_id])

    # Ažurirajte kako prihvatate i čuvate podatke
    dealt_card = DealtCard.new(
      game_id: params[:game_id],
      player1: params[:dealt_card][:player1Hand],
      player2: params[:dealt_card][:player2Hand],
      player3: params[:dealt_card][:player3Hand],
      table: params[:dealt_card][:newTable]
    )

    if dealt_card.save
      render json: { message: 'Dealt cards saved successfully' }, status: :created
    else
      render json: { error: 'Failed to save dealt cards' }, status: :unprocessable_entity
    end
  end

  # Akcija za brisanje podeljenih karata
  def destroy
    game = Game.find(params[:game_id])
    game.dealt_card.destroy
    render json: { message: 'Dealt cards deleted successfully' }, status: :ok
  end

   private

  def set_game
    @game = Game.find(params[:game_id])
  end

  # Ne morate ažurirati ovaj deo koda
  def dealt_card_params
    params.require(:dealt_card).permit(:player1Hand, :player2Hand, :player3Hand, :newTable, :game_id)
  end
end
