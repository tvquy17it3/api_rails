class Timesheet < ApplicationRecord
  acts_as_paranoid
  before_create :create_check_in
  belongs_to :user
  belongs_to :shift
  has_many :timesheet_details, -> { with_deleted }
  has_one :contact, through: :user
  # validates_associated :timesheet_details
  delegate :email, to: :user, prefix: true
  delegate :name, to: :shift, prefix: true, allow_nil: true
  delegate :name, to: :contact, prefix: true, allow_nil: true

  scope :with_checkin_today, ->(id) {
    where(check_in: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    .where(user_id: id)}

  enum status: [:notcheckout, :checkout], _prefix: true

  private
  def create_check_in
    self.check_in = Time.current
    self.check_out = Time.current
    self.hours = 0
    self.status = false
  end
end
