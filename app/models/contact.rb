class Contact < ApplicationRecord
  belongs_to :user
  validates :name, length:
    {
      minimum: 3,
      maximum: 100
    }
  validates :phone,:presence => true,
  :numericality => true,
  :length => { :minimum => 5, :maximum => 15 }
end
