class Level < ActiveRecord::Base
  @@logger = Logger.new "log/level.log"
  
  validates :name, presence: true
  validates :points, presence: true, numericality: { only_integer: true }, uniqueness: true
  validates :image, presence: true, format: { with: URI.regexp }
  validates_presence_of :points
  
  #TODO: Remove logic from current_level view
  def self.current_level(points)
    levels = Level.order(:points)
    
    levels.each_with_index do |level,index|
      if actions >= level.points
    
        current_level = level
        next_level = levels[index + 1]
      
      end
    end
    
    if current_level.nil?
      current_level.name = nil
      current_level.description = nil
      current_level.image = nil
    end
    
    current_level
  rescue => e
    @@logger.fatal "Error getting current_level: #{e.class} - #{e.message}"
  end
  
  
  
  
  
end
