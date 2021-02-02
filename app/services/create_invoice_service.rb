# frozen_string_literal: true

module InvoiceServices
  class CreateInvoiceService
    def initialize(params)
      @timesheets = params[:timesheets]
      @company = params[:company]
    end

    def call
      bills = create_bills(@timesheets)
      @merge_bills = merge_bills(bills)
      @total_cost = calculate_total_cost(bills)

      {
        company: @company,
        bills: @merged_bills,
        total_cost: @total_cost
      }
    end

    private

    def create_bills(timesheets)
      timesheets.map do |timesheet|
        number_of_hours = timesheet[:end_time].split(':')[0].to_i - timesheet[:start_time].split(':')[0].to_i
        {
          employee_id: timesheet[:employee_id],
          number_of_hours: number_of_hours,
          unit_price: timesheet[:billable_rate],
          bill_cost: timesheet[:billable_rate] * number_of_hours
        }
      end
    end

    def merge_bills(bills)
      hashed_bills = hash_bills(bills)
      hashed_bills.keys.map do |k|
        hash_bills[k]
      end
    end

    def calculate_total_cost
      @comp_bills.reduce(0) do |accum, bill|
        accum + (bill[:unit_price] * bill[:number_of_hours])
      end
    end

    def hash_bills(bills)
      bills.each_with_object({}) do |bill, accum_bill|
        emp_id = bill[:employee_id]
        if accum_bill[emp_id].nil?
          accum_bill[emp_id] = bill
        else
          accum_bill[emp_id][:bill_cost] = accum_bill[emp_id][:bill_cost] + bill[:bill_cost]
          accum_bill[emp_id][:bill_cost] = accum_bill[emp_id][:number_of_hours] + bill[:number_of_hours]
        end
      end
    end
  end
end
