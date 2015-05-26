class SendHoursController < ApplicationController
  def index
    if admin?
      @projects = ProjectInfo.find(:all)
      @employees = Employee.find(:all)
      @d = Date.today
    end
  end

  def create
    if admin?

      @project_time = Hash.new
      @bench_time = Hash.new
      @internal_time = Hash.new
      @project_submissions = Array.new
      
      begin
        @begin_date = build_date_from_params(:begin_date, params[:dates])
        @end_date = build_date_from_params(:end_date, params[:dates])
      rescue
        flash[:notice] = "Invalid Date!"
        redirect_to hours_summaries_path and return
      end

      if params[:employee][:id] == ""
        @employees = Employee.find(:all)
        
      else
        @employees = Employee.find([params[:employee][:id]])
      end

     
      
      if params[:project][:id] == ""
        @project_name = "All"
        
        @projects = ProjectInfo.find(:all,
                                     :conditions => ["id not in (?)",[bench_id,internal_id]])
        @project_ids = Array.new
     
        @projects.each do |p|
          @project_ids.insert(1,p.id)
        end
        
        @employees.each do |e|
          
          

          @submissions = TimeSubmission.find(:all,
                                             :conditions => 
                                             {:work_date => @begin_date..@end_date, 
                                               :employee_id => e.id, 
                                               :project_id => @project_ids})
          
          
          @bench = TimeSubmission.find(:all,
                                       :conditions => {:work_date => @begin_date..@end_date, 
                                         :employee_id => e.id, :project_id => bench_id})
          
          @bench_time[e.id] = to_num(sum_hours(@bench))
          
          @internal = TimeSubmission.find(:all,
                                          :conditions => 
                                          {:work_date => @begin_date..@end_date,
                                            :employee_id => e.id, 
                                            :project_id => internal_id})
          
          @internal_time[e.id] = to_num(sum_hours(@internal))
          
          @project_time[e.id] = to_num(sum_hours(@submissions))
          
        end
      else
        @project = ProjectInfo.find(params[:project][:id])
        @project_name = @project.client + ":" + @project.project_name
        @employees.each do |e|
          @submissions = TimeSubmission.find(:all,
                                             :conditions => {:project_id => @project.id, 
                                               :work_date => @begin_date..@end_date, 
                                               :employee_id => e.id})
          @bench = TimeSubmission.find(:all, 
                                       :conditions => {:project_id => bench_id, 
                                         :work_date => @begin_date..@end_date, 
                                         :employee_id => e.id})
          @internal = TimeSubmission.find(:all, 
                                          :conditions => {:project_id => internal_id, 
                                            :work_date => @begin_date..@end_date, 
                                            :employee_id => e.id})
          @project_time[e.id] = sum_hours(@submissions)
          @bench_time[e.id] = sum_hours(@bench)
          @internal_time[e.id] = sum_hours(@internal)
        end
        
              
      end
      
      

      TimeMailer.time_email(@employees, @begin_date, @end_date, 
                            @bench_time, @internal_time,
                            @project_time, @project_name).deliver
     
    end
  end
end
