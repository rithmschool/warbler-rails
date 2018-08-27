class PagesController < ApplicationController
  def home
    if current_user
      @messages = Message.order(created_at: :desc).limit(100)
    end
  end

  def search
    term = params[:q]
    if term.blank?
      @users = User.all
    else
      term_for_sql = "%#{term}%"
      @users = User.where("username LIKE ?", term_for_sql)
    end
  end
end
