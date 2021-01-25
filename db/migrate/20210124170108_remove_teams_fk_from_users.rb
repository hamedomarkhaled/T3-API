class RemoveTeamsFkFromUsers < ActiveRecord::Migration[6.0]
  def change
    if foreign_key_exists?(:users, :teams)
      remove_foreign_key :users, :teams
    end
  end
end
