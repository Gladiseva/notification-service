class NotificationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_before_action :verify_authenticity_token

  def index
    @notifications = Notification.all

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
    @notification.sender_id = current_user.id
    if @notification.save
      render json: @notification
    end
  end

  private
  def notification_params
    params.require(:notification).permit(:recipient_id, :title, :description)
  end

end
