class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :like, null: false, foreign_key: { to_table: :microposts } 

      t.timestamps
      
      t.index [:like_id, :user_id], unique: true
    end
  end
end