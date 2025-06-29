class CreateTodos < ActiveRecord::Migration[8.0]
  def change
    create_table :todos do |t|
      t.text :task
      t.date :date
      t.time :time
      t.boolean :status

      t.timestamps
    end
  end
end
