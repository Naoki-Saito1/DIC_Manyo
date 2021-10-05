class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :task_name, null: false
      t.string :content, null: false
      t.date :limit
      t.integer :status
      t.integer :priority
      t.timestamps
    end
  end
end
