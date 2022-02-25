class Api::V1::SessionController < Api::V1::AuthController
  before_action :load_user_authentication, :ensure_params_exist,  only: :create
  skip_before_action :current_user, only: :create
  skip_before_action :verify_signed_out_user, only: :destroy

  respond_to :json

  def create
    if @user.valid_password? user_params[:password]
      sign_in @user, store: false
      render json: {message: "Signed in successfully", user: @user}, status: 200
      return
    end
    invalid_login_attempt
  end

  def destroy
    if @current_user.authentication_token == bearer_token
      sign_out @current_user
      render json: {message: "Signed out"}, status: 200
    else
      render json: {message: "Invalid token"}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password
  end

  def invalid_login_attempt
    render json: {message: "Sign in failed"}, status: 401
  end

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    return login_invalid unless @user
  end

  def login_invalid
    render json: {message: "Invalid login"}, status: 401
  end
end
