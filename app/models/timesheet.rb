class Timesheet < ApplicationRecord
  before_create :create_check_in
  belongs_to :user
  has_many :timesheet_details, dependent: :destroy

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
