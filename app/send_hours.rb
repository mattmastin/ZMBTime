class SendHours < ApplicationController
  
  project_time = Hash.new
  bench_time = Hash.new
  internal_time = Hash.new
  project_submissions = Array.new
  
  #begin
  #  @begin_date = build_date_from_params(:begin_date, params[:dates])
  #  @end_date = build_date_from_params(:end_date, params[:dates])
  #rescue
  #  flash[:notice] = "Invalid Date!"
  #  redirect_to hours_summaries_path and return
  #end

  d=Date.today

  
  bench_id = ApplicationController.bench_id
  internal_id = ApplicationController.internal_id
  
  begin_date = d.beginning_of_week
  end_date = d.end_of_week
  
  employees = Employee.find(:all)
  
  project_name = "All"
  
  projects = ProjectInfo.find(:all,
                              :conditions => ["id not in (?)",[bench_id,internal_id]])
  project_ids = Array.new
  
  puts employees
  
  projects.each do |p|
    project_ids.insert(1,p.id)
  end
  
  employees.each do |e|
    submissions = TimeSubmission.find(:all,
                                      :conditions => 
                                      {:work_date => begin_date..end_date, 
                                        :employee_id => e.id, 
                                        :project_id => project_ids})
    
    bench = TimeSubmission.find(:all,
                                :conditions => {:work_date => begin_date..end_date, 
                                  :employee_id => e.id, :project_id => bench_id})
    
    bench_time[e.id] = to_num(sum_hours(bench))
    
    internal = TimeSubmission.find(:all,
                                   :conditions => 
                                   {:work_date => begin_date..end_date,
                                     :employee_id => e.id, 
                                     :project_id => internal_id})
    
    internal_time[e.id] = to_num(sum_hours(internal))
    
    project_time[e.id] = to_num(sum_hours(submissions))
    
  end
  
  TimeMailer.time_email(employees, begin_date, end_date, 
                        bench_time, internal_time,
                        project_time, project_name).deliver
  
end


