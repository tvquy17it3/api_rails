class Timesheet < ApplicationRecord
  before_create :cal_check_in
  belongs_to :user
  has_many :timesheet_details, dependent: :destroy

  scope :with_checkin_today, ->(id) {
    where(check_in: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
    .where(user_id: id)}

  enum status: [:notcheckout, :checkout], _prefix: true

  private
  def cal_check_in
    time = Time.current
    self.check_in = time
    self.check_out = time
    self.hours = 0
    self.status = false
  end
end
