class HoursReportsController < ApplicationController
  
  def index
    if logged_in?
      @projects = ProjectInfo.find(:all)
      @d = Date.today
      
    end
  end

  def create_csv(submissions, client_names, project_names, minutes_display)
    if logged_in?
      @submissions = submissions
      @client_names = client_names
      @project_names = project_names
      @minutes_display = minutes_display
      CSV.generate do |csv|
        csv << ["Client","Project Name","Date","Hours"]
        @submissions.each do |s|
          csv << [@client_names[s.project_id],@project_names[s.project_id],s.work_date,s.hours.to_s + ":" + @minutes_display[s.id]]
          
        end
      end
      
    end
  end
  
  def create
    if logged_in?
      begin
        @begin_date = build_date_from_params(:begin_date, params[:dates])
        @end_date = build_date_from_params(:end_date, params[:dates])
      rescue
        flash[:notice] = "Invalid Date!"
        redirect_to hours_reports_path and return
      end
      @client_names = Hash.new
      @project_names = Hash.new
      @minutes_display = Hash.new
      @not_found_message = ""

      if params[:project][:id] == ""
        
        @submissions = TimeSubmission.find(:all, :conditions => {:employee_id => current_emp, :work_date => @begin_date..@end_date}, :order => 'work_date')
      else
        @submissions = TimeSubmission.find(:all, :conditions => {:project_id => params[:project][:id],:employee_id => current_emp, :work_date => @begin_date..@end_date}, :order => 'work_date')
      end
      
      @submissions.each do |s|
        @client_names[s.project_id] = get_client(s.project_id)
        @project_names[s.project_id] = get_project_name(s.project_id)
        if s.minutes == 0
          @minutes_display[s.id] = "00"
        else
          @minutes_display[s.id] = s.minutes.to_s
        end
      end
      
      if @submissions.blank?
        @not_found_message = "No records found."
      end


      #flash[:notice] = params[:dates][:"begin_date(1i)"]
      #redirect_to employee_homes_path and return
    
      @csv = create_csv(@submissions, @client_names, @project_names, @minutes_display)
      @file = File.open("hours.csv",'w') do |f|
        f.puts @csv
      end
    end    
  end      
end
  
