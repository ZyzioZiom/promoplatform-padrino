class Message < ActiveRecord::Base
  @@logger = Logger.new "log/message.log"
  
  belongs_to :user
  
  validates :user, :content, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }
  
  def self.recent_messages
    Message.order(created_at: :desc).first(50)
  rescue => e
    logger.fatal "Error in getting recent messages: #{e.class} - #{e.message}"
  end
  
end
