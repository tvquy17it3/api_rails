class Api::V1::UserController < Api::V1::AuthController
  before_action :ensure_params_exist, except: :show

  def show
    user = User.includes(:contact).find_by(id: @current_user.id).as_json(include: :contact)
    render json: {message: "Infor user", user: user}, status: 200
  end

  def update
    if @current_user.update(user_params)
      render json: {message: "Completed", user: @current_user.contact}, status: 200
    else
      warden.custom_failure!
      render json: {message: @current_user.contact.errors.messages}, status: 200
    end
  end

  def change_password
    if @current_user.valid_password? user_params[:current_password]
      @current_user.password = (user_params[:password])
      if @current_user.save
        render json: {message: "Changed password completed", user: @current_user}, status: 200
      else
        warden.custom_failure!
        render json: {message: @current_user.errors.messages}, status: 200
      end
    else
      render json: {message: "Password incorect"}, status: 200
    end
  end

  private
  def user_params
    params.require(:user).permit(:current_password, :password, contact_attributes: [:name, :phone, :gender, :address])
  end
end
