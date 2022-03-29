class User < ApplicationRecord
  has_one :contact
  has_many :timesheets
  has_one_attached :avatar
  belongs_to :role
  accepts_nested_attributes_for :contact, update_only: true
  acts_as_token_authenticatable
  acts_as_paranoid
  delegate :name, :phone, :address, :gender,
  to: :contact, prefix: true, allow_nil: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  scope :with_contact, -> { includes(:contact).order('email ASC') }
end
