class SecretsController < ApplicationController
  before_action :user_authorized, only: [:index, :create]

  def index
    current_user = current_user()
    @secrets = Secret.all.includes(:user, :likes)
    @secrets_liked_ids = current_user.secrets_liked_ids
    # render "secrets.html.erb"
  end

  def create
    secret = Secret.create(secret_params.merge(user: current_user))

    if secret.valid?
      redirect_to "/secrets"
    else
      flash[:errors] = secret.errors.full_messages
      redirect_to "/users/#{session[:user_id]}"
    end
  end

  def destroy
    Secret.destroy(params[:secret_id])
    redirect_to "/secrets"
  end

  private
    def secret_params
      params.require(:secret).permit(:content)
    end
end
