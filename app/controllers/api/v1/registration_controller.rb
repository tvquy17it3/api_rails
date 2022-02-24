class Api::V1::RegistrationController < Devise::RegistrationsController
  before_action :ensure_params_exist
  respond_to :json

  def create
    user = User.new user_params
    if user.save
      render json: {message: "Registration has been completed", user: user}, status: 200
    else
      warden.custom_failure!
      render json: {message: user.errors.messages}, status: 200
    end
  end

  private
  def user_params
    role = Role.role_user.first
    params.require(:user).permit(:email, :password, :password_confirmation, contact_attributes: [:name, :phone]).reverse_merge({ role_id: role.id })
  end

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {message: "Missing params"}, status: 422
  end
end
