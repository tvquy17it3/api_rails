class User < ApplicationRecord
  acts_as_paranoid
  has_one :contact, -> { with_deleted }, dependent: :destroy
  has_many :timesheets
  has_one_attached :avatar
  belongs_to :role
  accepts_nested_attributes_for :contact, reject_if: :all_blank, update_only: true
  acts_as_token_authenticatable
  delegate :name, :phone, :address, :gender,
  to: :contact, prefix: true, allow_nil: true
  delegate :slug, to: :role, prefix: true, allow_nil: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: [:google_oauth2]
  scope :with_contact_role, -> { includes(:contact, :role) }
  scope :with_email, -> (email){ with_deleted.where email: email }

  def self.from_omniauth(access_token)
    user = User.with_email(access_token.info.email).first
    ActiveRecord::Base.transaction do
      unless user
        role = Role.user_role.first
        user = User.create(email: access_token.info.email,
          password: Devise.friendly_token[0,20],
          role_id: role.id)
        user.uid = access_token.uid
        user.image = access_token.info.image
        user.provider = access_token.provider
        user.build_contact(name: access_token.info.name)
        UserMailer.welcome(user).deliver if ENV["MAIL_WELCOME"]
      else
        unless user.contact
          user.build_contact
          user.contact.update(name: access_token.info.name)
        end
      end
      user.save!
    end
    return user
  end
end
