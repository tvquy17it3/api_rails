class Api::V1::AuthController < Devise::SessionsController
  protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User, {fallback: :none}
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :current_user

  rescue_from CanCan::AccessDenied do |exception|
    render json: {status: 'ERROR', message:'Not permission'}, status: 401
  end

  def current_ability
    @current_ability ||= Ability.new(@current_user, :api_auth)
  end

  private
  def ensure_params_exist
    return unless params[:user].blank?
    render json: {message: "Missing params"}, status: 422
  end

  def record_not_found
    render json: {status: 'ERROR', message:'Not found'}, status: 404
  end

  def bearer_token
    if request.headers['Authorization']
      return request.headers['Authorization'].split(' ').last
    end
    return false
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
