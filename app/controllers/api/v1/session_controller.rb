class Api::V1::SessionController < Devise::SessionsController
  before_action :ensure_params_exist, only: %i(create destroy)
  before_action :load_user_authentication,  only: :create
  before_action :current_user, only: %i(show destroy)
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

  def show
    render json: {message: "Signed in successfully", user: @current_user}, status: 200
  end

  def destroy
    if @current_user.authentication_token == user_params[:authentication_token]
      sign_out @user
      render json: {message: "Signed out"}, status: 200
    else
      render json: {message: "Invalid token"}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit :email, :password, :authentication_token
  end

  def invalid_login_attempt
    render json: {message: "Sign in failed"}, status: 200
  end

  def ensure_params_exist
    return unless params[:user].blank?
    render json: {message: "Missing params"}, status: 422
  end

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    return login_invalid unless @user
  end

  def login_invalid
    render json: {message: "Invalid login"}, status: 200
  end

  def current_user
    if request.headers['Authorization']
      token = request.headers['Authorization'].split(' ').last
      @current_user ||= User.find_by authentication_token: token
      render json: {message: "You are not authenticated"},
        status: 401 if @current_user.nil?
    else
      render json: {message: "You are not authenticated"},
        status: 401
    end
  end
end
