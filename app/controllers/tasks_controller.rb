# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show update destroy]

  def index
    @tasks = current_user.tasks
    json_response(@tasks)
  end

  def create
    @task = Task.create!(task_params)
    current_user.tasks << @task
    current_user.save
    json_response(@task, :created)
  end

  def show
    json_response(@task)
  end

  def update
    @task.update(task_params)
    head :no_content
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def task_params
    params.permit(:description, :status, :user_id)
  end

  def set_task
    raise ExceptionHandler::AuthenticationError if Task.find(params[:id].user_id != current_user.id)

    @task = Task.find(params[:id])
  end
end
