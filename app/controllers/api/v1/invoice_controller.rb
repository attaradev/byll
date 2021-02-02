# frozen_string_literal: true

module Api
  module V1
    class InvoiceController < ApiController
      before_action :set_company
      before_action :set_timesheets

      def create
        @invoice = InvoiceServices::CreateInvoice.new({
                                                        company: @company,
                                                        timesheets: @Timesheets
                                                      }).call

        render json: @invoice, status: :ok
      end

      private

      def set_timesheets
        @timesheets = Timesheet.all.select { |t| t[:company] == @company }
      end

      def set_company
        params[:company]
      end
    end
  end
end
