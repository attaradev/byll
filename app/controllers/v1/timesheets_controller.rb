# frozen_string_literal: true

class V1::TimesheetsController < ApplicationController
  before_action :user
  before_action :set_timesheet, only: %i[show update destroy]

  def index
    @timesheets = Timesheet.all
    render json: @timesheets, status: :ok
  end

  def create
    @timesheet = Timesheet.create(timesheet_params)
    if @timesheet.valid?
      render json: @timesheet, status: :ok
    else
      render json: @timesheet.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @timesheet, status: :ok
  end

  def update
    @timesheet = Timesheet.update(timesheet_params)
    if @timesheet.valid?
      render json: @timesheet, status: :ok
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
end

