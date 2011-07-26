class Tag < ActiveRecord::Base
  has_and_belongs_to_many :todos
  before_validation :trim_label, :set_color
  
  validates_presence_of :label
  validates_uniqueness_of :label
  validates_format_of :color, :with => /\#[a-f0-9]{6}/i, :message => "Not a valid html color."
  
  def trim_label
    self.label.strip if self.label
  end
  
  def set_color
    unless self.label.nil? || self.label.empty? then
      sha1 = Digest::SHA1.hexdigest(self.label)
      self.color = "#"+sha1.match("[0-9a-f]{6}")[0]
    end
  end
  
end
