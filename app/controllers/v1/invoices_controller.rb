# frozen_string_literal: true

class V1::InvoicesController < ApplicationController
  before_action :authenticate_user!,
                :finance_team!,
                :set_company,
                :set_timesheets

  def create
    @invoice = InvoiceServices::CreateInvoiceService.new({
                                                           company: @company,
                                                           timesheets: @timesheets
                                                         }).call
    render json: @invoice
  end

  private

  def set_company
    @company = params[:company]
  end

  def set_timesheets
    @timesheets = Timesheet.where(company: @company)
  end
end
