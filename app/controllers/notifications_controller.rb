class NotificationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def index
    @notifications = Notification.where(recipient: current_user)

    render json: @notifications
  end

  def show
    @notification = Notification.find(params[:id])
    @notification.update!(read_at: Time.zone.now)

    render json: @notification
  end

  def new
    @notification = Notification.new

    render json: @notification
  end

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      render json: @notification
    end
  end

  private
  def notification_params
    params.require(:notification).permit(:recipient_id, :sender_id, :title, :description)
  end

end
