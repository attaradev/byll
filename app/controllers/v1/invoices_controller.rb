# frozen_string_literal: true

module V1
  class InvoicesController < ApplicationController
    before_action :set_company
    before_action :set_timesheets

    def create
      @invoice = InvoiceServices::CreateInvoiceService.new({
                                                             company: @company,
                                                             timesheets: @timesheets
                                                           }).call

      render json: @invoice, status: :ok
    end

    private

    def set_timesheets
      @timesheets = Timesheet.where(company: @company)
    end

    def set_company
      @company = params[:company]
    end
  end
end
