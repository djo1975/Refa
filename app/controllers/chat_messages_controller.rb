class ChatMessagesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      @chat_messages = ChatMessage.all
      render json: @chat_messages
    end
  
    def create
      # Prvo proveri broj poruka
      if ChatMessage.count >= 50
        oldest_message = ChatMessage.order(:created_at).first
        oldest_message.destroy
      end
  
      chat_message = ChatMessage.new(chat_message_params)
      if chat_message.save
        render json: chat_message, status: :created
      else
        render json: { error: "Unable to save chat message" }, status: :unprocessable_entity
      end
    end
  
    private
  
    def chat_message_params
      params.require(:chat_message).permit(:user, :content)
    end
  end
  