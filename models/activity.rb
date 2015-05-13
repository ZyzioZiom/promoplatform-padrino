class Activity < ActiveRecord::Base

    
  
    def self.category(category)
      Activity.where(category: category).order(:date, :hour).group_by(&:date)
    end
  
    def self.current(activity_id, user_id)
      
    end
end
