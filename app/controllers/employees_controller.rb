class EmployeesController < ApplicationController
  def index
    if admin?
      if @employees = Employee.find(:all)
      else
        flash[:notice] = "There are no employees in the database"
        redirect_to admin_homes_path and return
      end
    end
  end
  
  def new
    if admin?
      @employee = Employee.new
    end
  end

  def update_info
    if logged_in?
      @employee = Employee.find_by_email(current_email)
    end
  end

  def create
    if admin?
      params[:employee][:email] = params[:employee][:email].downcase
      @employee = Employee.new(params[:employee])
      if @employee.save
        redirect_to employees_path
        flash[:notice] = "Employee " + @employee.first_name + " " + @employee.last_name  + " created!"
      else
        render "new"
      end
    end
  end

  def show
    if admin?
      @employee=Employee.find(params[:id]) 
    end
  end

  def update
    if logged_in? and params[:commit] == "Update Info"
      @employee = Employee.update(params[:id],params[:employee])

      if @employee.save
        flash[:notice] = "Employee " + @employee.first_name + " " + @employee.last_name + " up\
dated!"
        redirect_to employee_homes_path and return
      else
        render "show" and return
      end


    end


    if admin?
      params[:employee][:email] = params[:employee][:email].downcase
      @employee = Employee.update(params[:id],params[:employee])

      if @employee.save
        flash[:notice] = "Employee " + @employee.first_name + " " + @employee.last_name + " updated!"
        redirect_to employees_path
      else
        render "show"
      end
    end
  end

  def delete
    if admin?
      @employee = Employee.find(params[:id])
      Employee.delete(params[:id])
      flash[:notice] = "Employee " + @employee.first_name + " " + @employee.last_name + " deleted!"
      redirect_to employees_path
    end
  end 
end
