class TimesheetDetail < ApplicationRecord
  has_one_attached :image
  belongs_to :timesheet
  acts_as_paranoid
end
