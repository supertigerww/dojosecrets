class LikesController < ApplicationController
  before_action :user_authorized, only: [:create]

  def create
    Like.create(user: current_user, secret: Secret.find(params[:secret_id]))
    redirect_to "/secrets"
  end

  def destroy
    Like.find_by(user: current_user, secret: Secret.find(params[:secret_id])).destroy
    redirect_to "/secrets"
  end
end
