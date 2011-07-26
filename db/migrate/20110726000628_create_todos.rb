class CreateTodos < ActiveRecord::Migration
  def self.up
    create_table :todos do |t|
      t.string :input
      t.string :label
      t.timestamp :due_at
      t.boolean :done

      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
