class Shift < ApplicationRecord
  acts_as_paranoid
  has_many :timesheets, dependent: :destroy
end
