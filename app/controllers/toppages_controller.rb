class ToppagesController < ApplicationController
  def index
    if logged_in?
      @microposts = current_user.microposts.build # form_with 用
      @pagy, @microposts = pagy(current_user.microposts.order(id: :desc))
    end
  end
end
