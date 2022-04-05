class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  acts_as_paranoid
  enum slug: { admin_role: "admin", manager_role: "manager", user_role: "user" }
end
