class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    
    
    @tasks = Task.all
    # binding.irb

      @tasks = Task.order("created_at DESC")
  


  if params[:task].present?
    if params[:task][:task_name].present? && params[:task][:status].present?
    @tasks = Task.task_name(params[:task][:task_name]).status(params[:task][:status]).page(params[:page]).per(5)
      elsif params[:task][:task_name].present?
    @tasks = Task.task_name(params[:task][:task_name]).page(params[:page]).per(5)
      elsif params[:task][:status].present?
    @tasks = Task.status(params[:task][:status]).page(params[:page]).per(5)
    
    end
  end 
  if params[:sort_expired]
    @tasks = Task.order(limit: "DESC").page(params[:page]).per(5)
  end
  if params[:sort_priority]
    @tasks = Task.order(priority: "ASC").page(params[:page]).per(5)
  end
end
  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:task_name, :content, :limit, :status, :priority, :created_at)
    end
end
