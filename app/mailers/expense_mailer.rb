class ExpenseMailer < ActionMailer::Base
  default from: "time-expense@zmbdna.com"

  def expense_email(expense, employee, project, file_path, file_name)
    @expense = expense
    @employee = employee
    @project = project
    @file_path = file_path

#    @employee = Employee.find(@expense.employee_id)
    
#    @project = ProjectInfo.find(@expense.project_id)
    if File.exist?(@file_path)
      @file = File.read(@file_path)
      attachments[file_name] = File.read(@file_path)
    end
    mail(:to => "tyarbrough@zmbdna.com", :subject => "Expense Report")
  end
end
