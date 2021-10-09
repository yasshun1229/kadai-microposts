class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes]

  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 25)
  end

  def show
    find_user_id
    @pagy, @microposts = pagy(@user.microposts.order(id: :desc))
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy # 教材にはないですが、ユーザをどうしても削除したいことがあるので記載しました。
    find_user_id
    @user.destroy
  end

  def followings
    find_user_id
    @pagy, @followings = pagy(@user.followings)
    counts(@user)
  end

  def followers
    find_user_id
    @pagy, @followers = pagy(@user.followers)
    counts(@user)
  end
  
  def likes
    find_user_id
    @pagy, @likings = pagy(@user.likings)
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def find_user_id
    @user = User.find(params[:id])
  end
end