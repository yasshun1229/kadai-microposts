class ApplicationController < ActionController::Base
  
  include SessionsHelper # 追記
  include Pagy::Backend
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  # フォロー／フォロワー数のカウント
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likings = user.likings.count
  end
end