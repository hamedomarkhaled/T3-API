class User < ApplicationRecord
  belongs_to :team, optional: true
  has_many :tasks, dependent: :destroy

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
end
