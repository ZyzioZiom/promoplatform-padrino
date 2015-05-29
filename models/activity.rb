class Activity < ActiveRecord::Base
  @@logger = Logger.new "log/activity.log"
  
  has_many :actions, dependent: :destroy
  
  validates_inclusion_of :category, in: %w( leaflets stands posters others events )

  validates :points, presence: true
  def self.category(category)
    Activity.where(category: category).order(:date, :hour).group_by(&:date)
  rescue => e
    logger.fatal "Error in category method: #{e.class} - #{e.message}"
  end

  
  def self.import_csv(data)
    data.force_encoding "UTF-8"
    data = CSV.parse(data, headers: true, encoding: 'UTF-8')

    data.each do |line|
      headers = line.headers.first.split(";")
      values = line.fields.first.split(";")
      hash = Hash[headers.zip(values)]
      hash.symbolize_keys!
      Activity.create!(
        category: hash[:category], 
        hour: hash[:hour],
        day: hash[:day],
        date: hash[:date],
        place: hash[:place],
        name: hash[:name],
        description: hash[:description],
        points: hash[:points].to_i,
        image: hash[:image],
        global_talents: hash[:global_talents],
        global_citizen: hash[:global_citizen],
        career_days: hash[:career_days],
        career_forum: hash[:career_forum],
        future_leaders: hash[:future_leaders],
        aiesec_university: hash[:aiesec_university],
        youth_to_business_forum: hash[:youth_to_business_forum],
        global_host: hash[:global_host])
      
    end
    
    { result: "success"}
  rescue => e
    @@logger.error "Error importing CSV: #{e.class} - #{e.message}"
    { result: "error", error: e}
  end
end
