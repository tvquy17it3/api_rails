class TimesheetDetail < ApplicationRecord
  acts_as_paranoid
  has_one_attached :image
  belongs_to :timesheet

  validates :distance, :accuracy, :confidence, :presence => true,
    :numericality => true, allow_nil: true

  validates :latitude, :longitude, :ip_address, presence: true,
    length: { in: 2..20 }
end
