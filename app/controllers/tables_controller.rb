# class TablesController < ApplicationController
#     def deal
#       @game = Game.find(params[:id])
#       @player1 = Player.find(@game.creator_id)
#       @player2 = Player.find(@game.player2_id)
#       @player3 = Player.find(@game.player3_id)
  
#       # Logika za deljenje karata i određivanje dealera
#       suits = ['pik', 'karo', 'herc', 'tref']
#       ranks = ['7', '8', '9', '10', 'J', 'Q', 'K', 'A']
#       deck = ranks.product(suits).map { |rank, suit| { number: rank, suit: suit, status: 'undrawn' } }
#       deck.shuffle!
  
#       # Deljenje karata
#       hands = [@player2, @player3, @player1].map { |_| [] }  # Inicijalizacija ruku za tri igrača
#       talon = []
  
#       [2, 3, 1, 2, 3, 1].each do |player_index|
#         5.times do
#           card = deck.pop
#           hands[player_index - 1] << card
#         end
#       end
  
#       2.times do
#         card = deck.pop
#         talon << card
#       end
  
#       if @player1.nil? || @player2.nil? || @player3.nil?
#         # Handle the case when one or more players are not found
#         # Return an error response or redirect to an appropriate page
#         return
#       end

#  # Kreiranje instanci modela Card i vezivanje za igrača
#  hands.each_with_index do |hand, player_index|
#     player = instance_variable_get("@player#{player_index + 2}")
#     puts player.inspect 
#     hand.each do |card|
#       player.cards.create(card)
#     end
#   end
  
#       # Kreiranje instanci modela Card i vezivanje za talon
#       talon.each do |card|
#         @game.cards.create(card)
#       end
#     end
#   end
  