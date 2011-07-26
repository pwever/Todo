class AddTagsTodosTable < ActiveRecord::Migration
  def self.up
    create_table :tags_todos, :id => false do |t|
      t.references :tag, :todo
    end
  end

  def self.down
    drop_table :tags_todos
  end
end
