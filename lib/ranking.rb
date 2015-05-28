class Ranking
  
  def self.display
    
  end
  
  def self.current_level(current_user)
    sum_points = Action.sum_points(current_user)
    levels = Level.order(:points)
    
    current_level = nil
    next_level = levels.first
    
    levels.each_with_index do |level, index|
      if sum_points >= level.points
        current_level = level
        next_level = levels[index + 1]
      end
    end
    if next_level.nil? 
      percent = 100 
    else
      next_level = next_level.points
      percent = (sum_points.to_f - current_level.points) / next_level * 100
    end
    
    
    { :name => current_level.name, 
      :description => current_level.description,
      :points => current_level.points,
      :image => current_level.image,
      :percent => percent
      }
    
  end
  
end