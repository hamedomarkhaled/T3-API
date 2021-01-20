class User < ApplicationRecord
  belongs_to :team
  has_many :tasks

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email



end
