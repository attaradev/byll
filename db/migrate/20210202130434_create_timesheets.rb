class CreateTimesheets < ActiveRecord::Migration[6.1]
  def change
    create_table :timesheets do |t|
      t.integer :employee_id
      t.integer :billable_rate
      t.string :company
      t.string :date
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
    add_index :timesheets, :employee_id
  end
end
