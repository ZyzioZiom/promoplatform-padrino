class Message < ActiveRecord::Base

  def self.recent_messages
    Message.order(created_at: :desc).first(50)
  end
  
end
