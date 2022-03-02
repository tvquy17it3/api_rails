class Timesheet < ApplicationRecord
  belongs_to :user
  has_many :timesheet_details, dependent: :destroy
end
