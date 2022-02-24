class User < ApplicationRecord
  has_one :contact, dependent: :destroy
  belongs_to :role
  accepts_nested_attributes_for :contact
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

end
