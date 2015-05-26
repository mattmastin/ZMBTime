class ExpenseReportsController < ApplicationController

  def index
    if logged_in?
      @expense = ExpenseReport.new
      @projects = ProjectInfo.where(:open => true)
    end
  end

  def create
    if logged_in?
      
      
      if params[:project][:id]==""
        flash[:notice] = "You must select a project!"
        redirect_to expense_reports_path(:description => params[:expense_report][:description],:amount => params[:expense_report][:amount]) and return
      elsif params[:expense_report][:amount]==""
        flash[:notice] = "You must enter an amount!"
        redirect_to expense_reports_path(:description => params[:expense_report][:description],:amount => params[:expense_report][:amount]) and return
      elsif params[:expense_report][:description]==""
        flash[:notice] = "You must enter a description!"
        redirect_to expense_reports_path(:description => params[:expense_report][:description],:amount => params[:expense_report][:amount]) and return
      end
      @expense = ExpenseReport.new
      @expense.project_id = params[:project][:id]
      @expense.employee_id = current_emp
      @expense.amount = params[:expense_report][:amount]
      @expense.description = params[:expense_report][:description]

      if !@expense.save
        flash[:notice] = "Database error"
        redirect_to expense_reports_path(:description => params[:expense_report][:description],:amount => params[:expense_report][:amount]) and return
      end

      @employee = Employee.find(current_emp)
      @project = ProjectInfo.find(params[:project][:id])
      if params[:file]
        @file_path = params[:file].tempfile.to_path.to_s
        @file_name = params[:file].original_filename
      else
        @file_path = ""
        @file_name = ""
      end
      ExpenseMailer.expense_email(@expense, @employee, @project, @file_path, @file_name).deliver
    end
  end
end
