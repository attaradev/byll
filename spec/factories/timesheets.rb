FactoryBot.define do
  factory :timesheet do
    employee_id { 1 }
    billable_rate { 1 }
    company { "MyString" }
    date { "MyString" }
    start_time { "MyString" }
    end_time { "MyString" }
  end
end
