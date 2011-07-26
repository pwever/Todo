require 'test_helper'

class TagTest < ActiveSupport::TestCase

  test "check for empty label" do
    tag = Tag.new
    assert !tag.save, "We were able to save a tag without a label."
    
    tag = Tag.new
    tag.label = "       "
    assert !tag.save, "We were able to save a tag name with nothing by white space in it."
  end
  
  test "tag color is set" do
    tag = Tag.new
    tag.label = Time.now.to_s # create a unique tag
    tag.save
    assert_match /^\#[a-f0-9]{6}$/i, tag.color, "The tag color is not valid html."
  end
  
end
