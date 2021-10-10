class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  # フォロー関係の関連モデルへの追記
  has_many :microposts
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverses_of_relationship, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end
  
  def unfollow(other_user)
    relationships = self.relationships.find_by(follow_id: other_user.id)
    relationships.destroy if relationships
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id])
  end
  
  # お気に入り関係の関連モデルの追記
  has_many :favorites # 「自分がお気に入り登録しているMicropost」の参照
  has_many :likings, through: :favorites, source: :micropost # 「お気に入り登録しているMicropost」の取得
  # throughはモデル、sourceはどこから取得するか
  
  def like(other_micropost)
    self.favorites.find_or_create_by(micropost_id: other_micropost.id) # お気に入りの重複対策
  end
  
  def unlike(other_micropost) # お気に入り登録していれば外す
    like = self.favorites.find_by(micropost_id: other_micropost.id)
    like.destroy if like # favotiresが存在すれば、destroyする
  end
  
  def liking?(other_micropost)
    self.likings.include?(other_micropost) # お気に入り登録しているMicropostを取得し、お気に入りではないMicropostが含まれていないか確認
  end
  
  # def feed_microposts
  #   Micropost.where(user_id: self.likings_ids + [self.id])
  # end
end