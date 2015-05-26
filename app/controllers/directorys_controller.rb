class DirectorysController < ApplicationController

  def index
    if logged_in?
      @employees = Employee.find(:all)
    end
  end
end
