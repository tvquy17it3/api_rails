class Admin::UsersController < Admin::AdminsController
  before_action :load_user, only: %i(show unbanned destroy)

  def index
    @stt = 0
    @users = User.with_contact.page(params[:page]).per(8)
  end

  def show; end

  def banned
    @stt = 0
    @users = User.only_deleted.with_contact.page(params[:page]).per(8)
    render "index"
  end

  def unbanned
    if @user.restore
      flash[:success] = "Restore Success!"
    else
      flash[:danger] = "Error!!"
    end

    respond_to do |format|
      format.html
      format.js {
        render  :template => "admin/users/remove.js.erb",
                :layout => false
    }
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = "Banned!"
    else
      flash[:danger] = "Error!!"
    end

    respond_to do |format|
      format.html
      format.js {
        render  :template => "admin/users/remove.js.erb",
                :layout => false
      }
    end
  #  redirect_back(fallback_location: admin_user_path)
  end

  private
  def load_user
    @user = User.with_deleted.find_by(id: params[:id])
    return if @user
  end
end
