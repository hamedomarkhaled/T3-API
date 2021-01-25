# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:status) }
  it { should belong_to(:user) }
end
