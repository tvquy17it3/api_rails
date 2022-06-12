class Role < ApplicationRecord
  acts_as_paranoid
  has_many :users, dependent: :destroy
  enum slug: { admin_role: "admin", manager_role: "manager", user_role: "user" }
  validates :slug, presence: true, length:
    {
      minimum: 2,
      maximum: 15
    }
end
