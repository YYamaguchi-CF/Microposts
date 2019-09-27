class AccountsController < ApplicationController
  before_action :require_user_logged_in

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.assign_attributes(user_params)
    
    if @user.save
      flash[:success] = 'ユーザ情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報を更新できませんでした。'
      redirect_to edit_account_path, flash: { danger: @user.errors.full_messages }
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :content
      )
  end
end
