# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]
  skip_before_action :authorize_request, only: :create

  def index
    @users = User.all
    json_response(@users)
  end

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  def show
    json_response(@user, :ok, user_includes)
  end

  def update
    @user.update(user_params)
    head :no_content
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :team_id, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end

  def user_includes
    [:tasks]
  end
end
