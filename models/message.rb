class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity
  
  validates :user, :activity, :content, presence: true
  validates :who, presence: true, numericality: { only_integer: true }
  
  def self.recent_messages
    Message.order(created_at: :desc).first(50)
  end
  
end
