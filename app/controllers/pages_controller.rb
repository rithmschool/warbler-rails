class PagesController < ApplicationController
  def home
    if current_user
      'you are signed in'
    end
  end
end
