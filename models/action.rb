class Action < ActiveRecord::Base
  
  validates :user_id, :activity_id, presence: true
  validates :confirmation, presence: true, if: :confirmed?
  validates :points, presence: true, numericality: { only_integer: true }
  
  
  def self.signed(activity_id)
    Action.where(activity_id: activity_id)
  end
  
  def self.sum_confirmed
    Action.where(confirmed: true).group(:user_id).sum(:points) 
  end
  
  def current(activity_id, user_id)
    Action.where(activity_id: activity_id, user_id: user_id).first
  end
  
  def self.sum_points(user_id)
    Action.where(confirmed: true, user_id: user_id).sum(:points) 
  end
end
