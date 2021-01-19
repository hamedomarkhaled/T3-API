class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :team, foreign_key: true
      t.reference :tasks
      t.string :email

      t.timestamps
    end
  end
end
