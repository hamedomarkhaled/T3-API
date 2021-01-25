# frozen_string_literal: true

class RemoveTeamsFkFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :users, :teams if foreign_key_exists?(:users, :teams)
  end
end
