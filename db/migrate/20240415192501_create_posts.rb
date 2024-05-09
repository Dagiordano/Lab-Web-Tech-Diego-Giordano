class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|

      t.string :title
      t.text :content
      t.integer :user_id
      t.datetime :published_at
      t.integer :answers_count
      t.integer :likes_count

      
      t.timestamps
    end
  end
end
