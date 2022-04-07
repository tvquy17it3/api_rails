class Admin::TimesheetsController < Admin::AdminsController
  before_action :load_timesheet, only: :destroy
  authorize_resource

  def index
    @stt = 0
    @timesheets = Timesheet.page(params[:page]).order('check_in DESC').per(8)
  end

  def destroy
    respond_to do | format |
      begin
        if @timesheet.destroy
          flash[:success] = "Deleted!"
        else
          flash[:error] = "Error!!"
        end
      rescue => e
        flash[:error] = "Error!!"
      end
      format.js
    end
  end

  private
  def load_timesheet
    @timesheet = Timesheet.with_deleted.find_by(id: params[:id])
    return if @timesheet
  end
end
