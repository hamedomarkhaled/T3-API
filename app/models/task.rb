class Task < ApplicationRecord
  belongs_to :user


  validates_presence_of :description
  validates_presence_of :status
end
