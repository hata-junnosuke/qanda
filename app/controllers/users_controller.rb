class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      flash[:notice] = '失敗しました'
      render :new
    end
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to root_url, notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy!
    redirect_to root_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :admin, :password, :password_confirmation)
  end

end
