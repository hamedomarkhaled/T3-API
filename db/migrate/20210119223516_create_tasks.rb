class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.reference :task_tracker
      t.reference :user
      t.string :status

      t.timestamps
    end
  end
end
