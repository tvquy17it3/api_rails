class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  acts_as_paranoid
  enum slug: { admin_role: "admin", manager_role: "manager", user_role: "user" }
  validates :slug, presence: true, length:
    {
      minimum: 2,
      maximum: 15
    }
end
