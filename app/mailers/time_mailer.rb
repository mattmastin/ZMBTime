class TimeMailer < ActionMailer::Base
  default from: "time-expense@zmbdna.com"

  def time_email(employees, begin_date, end_date, bench_time, internal_time, project_time, project_name)
    @employees = employees
    @begin_date = begin_date
    @end_date = end_date
    @bench_time = bench_time
    @internal_time = internal_time
    @project_time = project_time
    @project_name = project_name
    
    mail(:to => "mmastin@zmbdna.com", :subject => "ZMB DnA Time Submission")
  end
end
