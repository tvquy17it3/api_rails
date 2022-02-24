class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  scope :role_user, -> { where(slug: :user) }
end
