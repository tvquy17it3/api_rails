class TimesheetDetail < ApplicationRecord
  has_one_attached :image
  belongs_to :timesheet
  acts_as_paranoid

  validates :distance, :accuracy, :confidence, :presence => true,
    :numericality => true, allow_nil: true

  validates :latitude, :longitude, :ip_address, presence: true,
    length: { in: 2..20 }
end
