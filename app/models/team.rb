# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :users

  validates_presence_of :name
end
