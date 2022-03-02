class Shift < ApplicationRecord
  has_many :timesheets, dependent: :destroy
  acts_as_paranoid
end
