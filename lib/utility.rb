class Utility
  
  def self.sanitize(string)
    string.gsub(/[^\w\*]/, "-")
  end
  
end