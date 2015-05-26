class CreateExpenseReports < ActiveRecord::Migration
  def change
    create_table :expense_reports do |t|
      t.string :project_id
      t.string :employee_id
      t.string :amount
      t.string :description 
      t.timestamps
    end
  end
end
