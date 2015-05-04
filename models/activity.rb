class Activity < ActiveRecord::Base

    def self.signed(activity_id)
      Action.where(activity_id: activity_id)
    end
end
