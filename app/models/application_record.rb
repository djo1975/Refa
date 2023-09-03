class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # app/controllers/chat_messages_controller.rb
class ChatMessagesController < ApplicationController
  def create
    message = ChatMessage.create(user: params[:user], content: params[:content])
    ActionCable.server.broadcast('chat', message.attributes) if message.persisted?
  end

  def index
    messages = ChatMessage.order(created_at: :desc).limit(50).reverse
    render json: messages
  end
end

end
