# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'chat'
  end

  def receive(data)
    chat_message = data['chat_message']
    broadcast_message(chat_message)
  end
  
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def broadcast_message(chat_message)
    if @last_messages.nil?
      @last_messages = []
    end
    
    @last_messages.push(chat_message)
    @last_messages.shift if @last_messages.length > 25

    ActionCable.server.broadcast('chat', chat_message)
  end
end
