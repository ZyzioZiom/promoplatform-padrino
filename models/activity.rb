class Activity < ActiveRecord::Base
  has_many :actions, dependent: :destroy
  
  validates_inclusion_of :category, in: %w( leaflets stands posters others events )

  validates :points, presence: true
  def self.category(category)
    Activity.where(category: category).order(:date, :hour).group_by(&:date)
  end

  def self.current(activity_id, user_id)

  end
  
  def self.import_csv(data)
    CSV.parse(data, headers: true, encoding: 'UTF-8')
  end
end
