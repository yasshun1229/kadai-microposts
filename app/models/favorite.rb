class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :micropost, class_name: "Micropost"
  
  # def feed_microposts # タイムライン用のMicropostを取得
  #   Micropost.where(user_id: self.liking_ids + [self.id]) # Micropost.where(user_id: お気に入りのMicropost + 自分自身)
  # end
end
