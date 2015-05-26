class TimeSubmission < ActiveRecord::Base
  attr_accessible :project_id, :employee_id, :work_date, :hours, :minutes

  after_save :delete_zero_entries

  def delete_zero_entries
    if self.hours == 0  and self.minutes == 0
      self.destroy
      
    end
  end

  def date
    return self.work_date
  end
end
