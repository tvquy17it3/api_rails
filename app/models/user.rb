class User < ApplicationRecord
  has_one :contact
  has_many :timesheets
  has_one_attached :avatar
  belongs_to :role
  accepts_nested_attributes_for :contact, reject_if: :all_blank, update_only: true
  acts_as_token_authenticatable
  acts_as_paranoid
  delegate :name, :phone, :address, :gender,
  to: :contact, prefix: true, allow_nil: true
  delegate :slug, to: :role, prefix: true, allow_nil: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]
  scope :with_contact_role, -> { includes(:contact, :role) }

  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first
    ActiveRecord::Base.transaction do
      unless user
        role = Role.user_role.first
        user = User.create(email: access_token.info.email,
          password: Devise.friendly_token[0,20],
          role_id: role.id)
        user.build_contact(name: access_token.info.name)
        UserMailer.welcome(user).deliver
      else
        user.build_contact unless user.contact
        user.contact.update(name: access_token.info.name)
      end
      user.uid = access_token.uid
      user.image = access_token.info.image
      user.provider = access_token.provider
      user.save
    end
    return user
  end
end
