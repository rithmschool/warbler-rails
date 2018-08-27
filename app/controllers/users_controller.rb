class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :find_user

  private

  def find_user
    @user = User.find(params[:id])
  end
end
