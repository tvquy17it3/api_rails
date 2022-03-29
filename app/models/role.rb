class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  acts_as_paranoid
  enum role_status: [:active, :inactive], _prefix: :comments
  scope :role_user, -> { where(slug: :user).first }

  enum slug: { admin_role: 'admin', manage_role: 'manage', user_role: "user" }
end
