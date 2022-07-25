class TasksController < ApplicationController
  before_action :confirm_login
  before_action :load_task, :confirm_owner, except: [:index, :new, :create]
  
  def index
    @tasks = current_user.tasks.all
  end

  def new
    @task = Task.new
  end

  def show
    #@task = Task.find(params[:id])
  end

  def edit
    #@task = Task.find(params[:id])

  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path
    else 
      render 'new'
    end
  end

  def update
    #@task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path
    else 
      render 'edit'
    end
  end
  
  def destroy
    #@task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end
  private
  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

  def confirm_login
    unless current_user
      redirect_to root_path, alert: "You need to login first"
    end
  end

  def load_task 
    @task = Task.find(params[:id])
  end

  def confirm_owner
    #@task = Task.find(params[:id])
    if @task && current_user != @task.user
      redirect_to tasks_path, alert: "You do not have permission to view this"
    end
  end
end
