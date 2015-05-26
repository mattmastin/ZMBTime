class SubmitHoursController < ApplicationController
  def index
    if logged_in?
      
      if params[:commit] == "Submit Hours"
        @new_hours = params[:sub_hours].keep_if{|key,value| value != ""}
        @new_minutes = params[:sub_minutes].keep_if{|key,value| value != ""}
        @new_dates = @new_hours.keys + @new_minutes.keys
        @new_dates.uniq!
        
        @new_dates.each do |date|
          @sub = TimeSubmission.where("project_id = ? AND employee_id = ? AND work_date = ?",params[:project_id],current_emp,Date.parse(date.gsub('-', '/')))
          if @new_hours[date] and !@new_minutes[date]
            @new_minutes[date] = 0
          elsif !@new_hours[date] and @new_minutes[date]
            @new_hours[date] = 0
          end

          if @sub.blank?
            TimeSubmission.create!(:project_id => params[:project_id], :employee_id => current_emp, :hours => @new_hours[date],:minutes => @new_minutes[date], :work_date => Date.parse(date.gsub('-', '/')))
            flash[:notice] = "Hours Submitted!"
          elsif !@sub.blank?
            @sub.each do |s|
              @temp = TimeSubmission.update(s.id,:hours => @new_hours[date], :minutes => @new_minutes[date])
              flash[:notice] = "Hours Submitted!"
            end
          end
        end
        
        redirect_to "/submit_hours/"+params[:project_id] and return
      end

      if params[:commit] == "Select Project"
        if params[:project][:id]==""
          flash[:notice] = "You must select a project!"
          redirect_to submit_hours_path and return
        else
          redirect_to "/submit_hours/" + params[:project][:id] and return
        end
      end

      
      # @submissions = Array.new(1,TimeSubmission.new)
      # @minutes_show = Hash.new

      if params[:project_id]
        @disable_cal = false
        @project = ProjectInfo.find(params[:project_id])
        @submissions = TimeSubmission.where("project_id = ? AND employee_id = ?",params[:project_id].to_i,current_emp)
        @minutes_show = Hash.new
        @submissions.each do |s|
          if s.minutes == 0
            @minutes_show[s.work_date] = "00"
          else
            @minutes_show[s.work_date] = s.minutes
          end
        end
      else
        @disable_cal = true
      end

      @projects = ProjectInfo.where(:open => true)

      @hours = Array (0..23)
      @mins = [0,15,30,45]

#      @submissions = Array.new(1,TimeSubmission.new)
#      @submissions.each do |s|
#        s.work_date = Date.today
      
      
      @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    end
  end

  def create
    if logged_in?
      
      if params[:commit] == "Select Project"
        if params[:project][:id]==""
          flash[:notice] = "You must select a project!"
          redirect_to submit_hours_path and return
        else
          redirect_to "/submit_hours/" + params[:project][:id] and return
          #redirect_to submit_hours_path, :project_id => params[:project][:id] and return
        end
      end

      if params[:commit] == "Submit Hours"
        flash[:notice] = "You must select a project!"
        redirect_to submit_hours_path and return
      end
      
      #if params[:commit] == "Submit Hours" and params[:project_id] == ""
      #  flash[:notice] = "You must select a project!"
      #  redirect_to submit_hours_path and return
      #end
      
     
#      hours = params[:sub_hours].select(|key,value| value!="")

    end
  end
end
