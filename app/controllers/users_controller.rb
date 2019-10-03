class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followings, :followers, :likes]
  before_action :require_user_logged_in, only: [:index, :show, :edit, :destroy, :followings, :followers]
  
  def index
    @q = User.order(id: :desc).ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @microposts = @user.microposts.recent.page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。メールを送信しました。'
      UserMailer.creation_email(@user).deliver_now
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @microfavos = @user.microfavos.page(params[:page]).per(10)
    counts(@user)
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(
      :name, 
      :email, 
      :password, 
      :password_confirmation,
      )
  end
end