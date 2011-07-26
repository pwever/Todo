class Todo < ActiveRecord::Base
  has_and_belongs_to_many :tags
  before_save :parse
  
  COLL_PATTERN = /\s+  (today|tonight|tomorrow) \s? (.*) /ix
  DATE_PATTERN = /\s+  (on|next|at|in|after|this)  \s  (\d|jan|feb|mar|apr|may|jun|jul|aug|sep|oct|dec|mon|tue|wed|thu|fri|sat|sun|week|month|year|afternoon|evening).*  $/ix
  TAG_PATTERN = /\s#(\w+)/i
  # DATE_PATTERN = /\s+  (on|next|at|in|after|this|tomorrow)  \s  [\s\w]*  $/ix
  # CONTEXT_PATTERN = /\s   (?: \@     (\w+)   |  [\@c]   (?:\w*)?  (?=['"\(\[\{])  ['"\(\[\{]  (.+)  ['"\)\}\}] )   /ix
  
  
  def parse
    self.input = self.label.clone # save user input for debugging
    
    # Check for tags
    if TAG_PATTERN.match(self.label) then
      # clear previous tags, if one is specified now
      self.tags = []
    end
    
    while match = TAG_PATTERN.match(self.label) do
      if match[1]
        tag_label = match[1]
        tag = Tag.find_or_create_by_label(tag_label)
        self.tags << tag
        self.label.gsub!(match[0],'') # remove the tag
      end
    end
    self.tags.uniq!
    
    matches = COLL_PATTERN.match(self.label)
    matches = DATE_PATTERN.match(self.label) unless matches
    due = Todo.parseTime(matches[0]) if matches
    if due
      # set due date
      self.due_at = due
      # remove time reference from label
      self.label.gsub!(matches[0], '')
    end
    
  end
  
  def self.parseTime str
    str.gsub! /^\s*(on|at)\s+/i, ""
    p "date string::::" + str
    t = Chronic.parse(str, {:guess => false})
    t = t.first if t
    # some rare cases are only handled by Time.parse (for instance "at 8pm")
    t = Time.parse(str) unless t
    # Time.prase returns the current time, if it can not match anything
    t = nil if (t-Time.now).abs < 15
    t
  end
  
  def setdone=(state)
    toggleDone unless (state==self.done)
  end

  def toggleDone
    self.done = !self.done
    if self.done
      self.done_at = Time.now
    else
      self.done_at = nil
    end
  end

  def isDue?
    self.due_at && self.due_at < Time.now
  end
  
  def isCurrent?
    self.due_at==nil || (Time.now-self.due_at)<60*60*12
  end
  
  def <=>(other)
      if (self.due_at==nil) then
        return 1
      elsif (other.due_at==nil) then
        return -1
      else
        due_at<=>other.due_at
      end
  end
  
end
