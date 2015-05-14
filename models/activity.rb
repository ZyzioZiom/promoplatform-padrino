class Activity < ActiveRecord::Base
  has_many :actions, dependent: :destroy
  
  def self.category(category)
    Activity.where(category: category).order(:date, :hour).group_by(&:date)
  end

  def self.current(activity_id, user_id)

  end
end
