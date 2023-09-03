class ChatMessage < ApplicationRecord
    validates :user, presence: true
    validates :content, presence: true
  
    default_scope { order(created_at: :asc) }
  end
  