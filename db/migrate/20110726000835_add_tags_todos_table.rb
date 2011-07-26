class AddTodosTagsTable < ActiveRecord::Migration
  def self.up
    create_table :tags_todos do |t|
      t.integer :tag_id
      t.integer :todo_id
    end
  end

  def self.down
    drop_table :tags_todos
  end
end
