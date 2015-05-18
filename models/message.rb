class Message < ActiveRecord::Base
  belongs_to :user
  
  validates :user, :content, presence: true
  validates :user_id, presence: true, numericality: { only_integer: true }
  
  def self.recent_messages
    Message.order(created_at: :desc).first(50)
  end
  
end
