class Role < ApplicationRecord
  has_many :users, dependent: :destroy
  acts_as_paranoid

  scope :role_user, -> { where(slug: :user) }
end
