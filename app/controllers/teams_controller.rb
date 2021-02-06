# frozen_string_literal: true

class TeamsController < ApplicationController
  before_action :set_team, only: %i[show update destroy]

  def index
    @teams = Team.all
    json_response(@teams)
  end

  def create
    @team = Team.create!(team_params)
    current_user.team_id = @team.id
    current_user.save
    json_response(@team, :created)
  end

  def show
    json_response(@team, :ok, team_includes)
  end

  def update
    @team.update(team_params)
    head :no_content
  end

  def destroy
    @team.destroy
    head :no_content
  end

  private

  def team_params
    params.permit(:name)
  end

  def set_team
    raise ExceptionHandler::AuthenticationError unless user_team_member?

    @team = Team.find(params[:id])
  end

  def user_team_member?
    processed_team = Team.find(params[:id])
    raise ActiveRecord::RecordNotFound unless processed_team

    processed_team.users.include?(current_user)
  end

  def team_includes
    [users: { include: :tasks }]
  end
end
