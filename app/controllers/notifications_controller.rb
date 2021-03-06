class NotificationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  skip_before_action :verify_authenticity_token

  rescue_from CanCan::AccessDenied do |exception|
    render json: exception.message
  end

  rescue_from ::ActiveRecord::RecordNotFound do |exception|
    render json: exception.message
  end

  def index
    @notifications = Notification.where(recipient: current_user)
                         .or(Notification.where(sender: current_user)).most_relevant

    render json: @notifications
  end

  def show
    @notification = Notification.where(recipient: current_user).find(params[:id])
    @notification.update!(read_at: Time.zone.now)

    render json: @notification
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.sender_id = current_user.id
    if @notification.save
      redirect_to root_path
    elsif render json: 'Unable to save notification. Fields recipient_id, title, description must not be nil.'
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    if @notification.read_at && @notification.recipient_id == current_user.id
      @notification.destroy
    end

    redirect_to root_path
  end

  private

  def notification_params
    params.require(:notification).permit(:recipient_id, :title, :description)
  end

end
