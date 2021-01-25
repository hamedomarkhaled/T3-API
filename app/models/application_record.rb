# frozen_string_literal: true

# Base class for the Application records
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
