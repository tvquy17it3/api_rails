class Api::V1::TimesheetsController < Api::V1::AuthController
  before_action :load_timesheet, only: :show
  before_action :load_timesheet_details, only: :details
  before_action :check_exist_timesheet, only: :create

  def show
    render json: {message: "ok", timesheet: @timesheet}, status: 200
  end

  def details
    render json: {message: "ok", timesheet: @timesheet}, status: 200
  end

  def list
    ts = @current_user.timesheets.order('check_in DESC').page(params[:page]).per(5)
    render json: {message: "ok", timesheet: ts}, status: 200
  end

  def create
    if @timesheet
      ActiveRecord::Base.transaction do
        ts = @timesheet
        ts.status = 1
        ts.check_out = Time.current
        ts.timesheet_details.build timesheet_detail_params
        ts.save
        render json: {message: "Updated", timesheet: ts}, status: 201
      end
    else
      ActiveRecord::Base.transaction do
        ts = @current_user.timesheets.build timesheet_params
        ts.timesheet_details.build timesheet_detail_params
        ts.save!
        render json: {message: "Created", timesheet: ts}, status: 201
      end
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render json: {message: invalid.record.errors}, status: 401
  end

  private
  def timesheet_params
    time = Time.current
    params.require(:timesheet)
          .permit(:location, :hours, :late, :note, :user_id, :shift_id)
          .merge(check_in: time, check_out: time, status: 0)
  end

  def timesheet_detail_params
    params.require(:timesheet_detail)
          .permit(:latitude, :longitude, :distance, :accuracy,
                  :ip_address, :confidence, :image, :note)
  end

  def load_timesheet
    @timesheet = Timesheet.includes(:user)
                          .find_by(id: params[:id])
                          .as_json(include: :user)
    return if @timesheet

    render json: {message: "Not found!"}, status: 200
  end

  def load_timesheet_details
    @timesheet = Timesheet.includes(:user, :timesheet_details)
                          .find_by(id: params[:id])
                          .as_json(include: [:user, :timesheet_details])
    return if @timesheet

    render json: {message: "Not found!"}, status: 200
  end

  def check_exist_timesheet
    @timesheet = Timesheet.where(check_in: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day)
                          .where(user_id: @current_user.id)
                          .first
  end
end
