class LabelsController < ApplicationController
  before_action :set_params, only: %i[ show edit update destroy ]
    @label = label.new
  end

  def index
    @labels = Label.all 
  end

  def create
    @label = Label.new(label_params)
    if label.save
      redirect_to tasks_path
   end
  end
  private
    def set_params
      @label = Label.find(params[:id])
    end
    def label_params
      params.require(:label).permit(:name)
    end
end

