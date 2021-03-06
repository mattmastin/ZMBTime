class CreateTimeSubmissions < ActiveRecord::Migration
  def change
    create_table :time_submissions do |t|
      
      t.string :project_id
      t.string :employee_id
      t.date :work_date, :null => false, :default => Date.today
      t.integer :hours
      t.integer :minutes

      t.timestamps
    end
  end
end
