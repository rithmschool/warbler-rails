class PagesController < ApplicationController
  def home
    if current_user
      @messages = Message.order('created_at').limit(100)
    end
  end
end
