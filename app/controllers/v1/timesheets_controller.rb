# frozen_string_literal: true

class V1::TimesheetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_timesheet, only: %i[show update destroy]
  before_action :authorize_access, only: %i[show update destroy]
  before_action :authorize_create, only: [:create]

  def index
    if finance_team?
      @timesheets = Timesheet.all
    else
      @timesheets = Timesheet.select { |t| t.employee_id == current_user.id }
    end
    render json: @timesheets
  end

  def create
    @timesheet = Timesheet.create(timesheet_params)
    if @timesheet.valid?
      render json: @timesheet
    else
      render json: @timesheet.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @timesheet
  end

  def update
    @timesheet = Timesheet.update(timesheet_params)
    if @timesheet.valid?
      render json: @timesheet
    else
      render json: @timesheet.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @timesheet.destroy
    render json: nil, status: :no_content
  end

  private

  def set_timesheet
    @timesheet = Timesheet.find(params[:id])
  end

  def timesheet_params
    params.permit(:employee_id, :billable_rate, :company, :date, :start_time, :end_time)
  end

  def authorize_access
    head :unauthorized unless finance_team? or current_user.id == @timesheet.employee_id
  end

  def authorize_create
    byebug
    head :unauthorized unless finance_team? or current_user.id == params[:employee_id]
  end
end

