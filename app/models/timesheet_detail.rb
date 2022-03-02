class TimesheetDetail < ApplicationRecord
  has_one_attached :image
  belongs_to :timesheet
end
