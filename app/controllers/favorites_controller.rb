class FavoritesController < ApplicationController
  before_action :require_user_logged_in # 前提条件：ユーザがログイン中
  
  def create
    micropost = Micropost.find(params[:micropost_id]) # 変数
    current_user.like(micropost) # 現在のユーザが（micropost）をlikeしました
    flash[:success] = "Micropostをお気に入り登録しました"
    redirect_to current_user
  end

  def destroy
    micropost = Micropost.find(params[:micropost_id])
    current_user.unlike(micropost)
    flash[:success] = "Micropostのお気に入り登録を解除しました"
    redirect_to current_user
  end
end