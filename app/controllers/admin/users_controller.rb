class Admin::UsersController < Admin::AdminsController
  before_action :load_user, only: %i(show unbanned destroy)
  before_action :set_search, only: %i(index banned)

  def index
    @users = User.with_contact_role.page(params[:page]).order('email ASC').per(8)
  end

  def show; end

  def search
    @q = User.with_deleted.ransack(params[:q])
    @users = @q.result.with_contact_role.page(params[:page]).per(8)
    @stt = 0
    respond_to do |format|
      format.js { render partial: "search-results"}
    end
  end

  def banned
    @users = User.only_deleted.with_contact_role.order('email ASC').page(params[:page]).per(8)
    render "index"
  end

  def unbanned
    respond_to do | format |
      begin
        if @user.restore
          flash[:success] = "Restore Success!"
        else
          flash[:error] = "Error!!"
        end
      rescue => e
        flash[:error] = "Error!!"
      end
      format.html
      format.js {
        render  :partial => "remove"
      }
    end
  end

  def destroy
    respond_to do | format |
      begin
        if @user.destroy
          flash[:success] = "Banned!"
        else
          flash[:error] = "Error!!"
        end
      rescue => e
        flash[:error] = "Error!!"
      end
      format.html
      format.js {
        render  :partial => "remove"
      }
    end
    # redirect_back(fallback_location: admin_user_path)
  end

  private
  def load_user
    @user = User.with_deleted.find_by(id: params[:id])
    return if @user
  end

  def set_search
    @stt = 0
    @q = User.ransack(params[:q])
  end
end
