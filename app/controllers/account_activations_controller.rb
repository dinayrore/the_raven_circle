class AccountActivationsController < ApplicationController
  def edit
    @user = User.find_by(email: params[:email])
    if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
      @user.activate
      log_in user
      flash[:success] = "Account Successfully Activated - Get ready to Experience Tranquility!"
      redirect_to @user
    else
      flash[:danger] = "Invalid Account Activation - There is disquiet in your soul..."
      redirect_to root_url
    end
  end
end
