class AddDoneAtToTodos < ActiveRecord::Migration
  def self.up
    add_column :todos, :done_at, :timestamp
  end

  def self.down
    remove_column :todos, :done_at
  end
end
