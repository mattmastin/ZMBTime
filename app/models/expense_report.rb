class ExpenseReport < ActiveRecord::Base
  attr_accessible :project_id, :employee_id, :amount, :description
end
