class ProjectInfosController < ApplicationController
  def index
    if admin?
      @projects = ProjectInfo.find(:all)
    end
  end
  def new
    if admin?
      @project = ProjectInfo.new
    end
  end

  def create
    if admin?
      @project = ProjectInfo.new(params[:project_info])
      if @project.save
        redirect_to project_infos_path
        flash[:notice] = "Project " + @project.project_name + " for  " + @project.client  + " created!"
      else
        render "new"
      end
    end
  end

  def show
    if admin?
      @project = ProjectInfo.find(params[:id])
    end
  end

  def update
    if admin?
      @project = ProjectInfo.update(params[:id],params[:project_info])
      if @project.save
        flash[:notice] = "Project " + @project.project_name + " for  " + @project.client  + " updated!"
        redirect_to project_infos_path
      else
        render "show"
      end
    end
  end

  def delete
    if admin?
      @project = ProjectInfo.find(params[:id])
      ProjectInfo.delete(params[:id])
      flash[:notice] = "Project " + @project.project_name + " for  " + @project.client  + " deleted!"
      redirect_to project_infos_path
    end
  end



end
