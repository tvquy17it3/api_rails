class Contact < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  validates :name, presence: true, length:
    {
      minimum: 3,
      maximum: 50
    }
  validates :phone, :presence => true,
    :length => { :minimum => 5, :maximum => 15 }, allow_nil: true

  validates :gender, length:
  {
    minimum: 1,
    maximum: 6
  }, allow_nil: true

  validates :address, length:
  {
    minimum: 5,
    maximum: 250
  }, allow_nil: true
end
