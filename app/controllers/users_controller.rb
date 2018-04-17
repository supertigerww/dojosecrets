class UsersController < ApplicationController
  before_action :user_logged_in, only: [:new]

  def new
    # render "new.html.erb"
  end

  def create
    user = User.create(user_params)

    if user.valid?
      session[:user_id] = user.id
      redirect_to "/secrets"
    else
      flash[:errors] = user.errors.full_messages
      redirect_to "/"
    end
  end

  def show
    @user = current_user
    # render "show.html.erb"
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthdate)
    end
end
