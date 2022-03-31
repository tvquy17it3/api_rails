class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  layout "admin"

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Not permission"
    respond_to do |format|
      format.js {
        render  :partial => "toastr"
      }
      format.html { render "admin/admins/index" }
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, :admin)
  end

  private
  def record_not_found
    flash[:error] = "record_not_found"
    format.js {
      render  :partial => "toastr"
    }
  end

  def is_admin?
    redirect_to root_path unless current_user.role.admin_role?
  end
end
