# frozen_string_literal: true

class Timesheet < ApplicationRecord
  validates :employee_id, :billable_rate, numericality: true
  validates :company, presence: true
  validates :date, format: {
    with: /^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$/,
    message: 'must be in the format YYYY-MM-DD',
    multiline: true
  }
  validates :start_time, :end_time, format: {
    with: /^(2[0-3]|[01]?[0-9]):([0-5]?[0-9])$/,
    message: 'must be in the format HH:MM',
    multiline: true
  }
end
