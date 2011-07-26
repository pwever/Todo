require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  
  test "check for blank todos" do
    todo = Todo.new
    assert !todo.save, "We were able to save a blank todo."
  end
  
  test "check tag parsing mechanism" do
    # remove the tag, in case it exists
    tag = Tag.find_by_label("car")
    tag.destroy if tag
    
    todo = Todo.new
    todo.label = "Change oil #car"
    todo.save
    assert_no_match /\#w{1,}/, todo.label, "The #tag was not removed from the todo label."
    assert_not_nil Tag.find_by_label("car"), "It seems the tag was not created."
    
    tag = Tag.find_by_label("home")
    tag.destroy if tag
    
    todo = Todo.new
    todo.label = "Wash #car #home the Rav4"
    todo.save
    assert Tag.find_by_label("car").todos.include?(todo), "Seems the tags was not associated with the todo item."
    assert_not_nil Tag.find_by_label("home"), "Check whether multiple tags are parsed correctly."
  end
  
  test "done defaults to false" do
    todo = Todo.new
    todo.label = "Something rather rather"
    todo.save
    
    assert_not_nil todo.done, "Seems like todo.done does not default to 'false'."
  end
  
end
