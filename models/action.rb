class Action < ActiveRecord::Base
  @@logger = Logger.new "log/action.log"
  
  validates :user_id, :activity_id, presence: true
  validates :confirmation, presence: true, if: :confirmed?
  validates :points, presence: true, numericality: { only_integer: true }
  
  
  def self.signed(activity_id)
    Action.where(activity_id: activity_id)
  rescue => e
    logger.fatal "Error in signed method: #{e.class} - #{e.message}"
  end
  
  def self.sum_confirmed
    Action.where(confirmed: true).group(:user_id).sum(:points) 
  rescue => e
  logger.fatal "Error in sum_confirmed method: #{e.class} - #{e.message}"
  end
  
  def current(activity_id, user_id)
    Action.where(activity_id: activity_id, user_id: user_id).first
  rescue => e
    logger.fatal "Error in current activity method: #{e.class} - #{e.message}"
  end
  
  def self.sum_points(user_id)
    Action.where(confirmed: true, user_id: user_id).sum(:points) 
  rescue => e
    logger.fatal "Error in sum_points method: #{e.class} - #{e.message}"
  end
end
