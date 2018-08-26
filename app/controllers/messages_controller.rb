class MessagesController < ApplicationController
  before_action :authenticate_user!, except: :show

  def new
    @message = Message.new
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(message_params.merge({ user_id: current_user.id }))
    if @message.valid?
      @message.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def destroy
    Message.find(params[:id]).destroy
    redirect_to user_path(current_user)
  end

  private

  def message_params
    params.require(:message).permit(:text)
  end
end
