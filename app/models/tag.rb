class Tag < ActiveRecord::Base
  has_and_belongs_to_many :todos
  before_save :setColor
  
  def setColor
    sha1 = Digest::SHA1.hexdigest(self.label)
    self.color = "#"+sha1.match("[0-9a-f]{6}")[0]
  end
  
end
