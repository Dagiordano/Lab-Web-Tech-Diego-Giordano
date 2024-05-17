class Post < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :tags
    has_many :comments
    accepts_nested_attributes_for :comments
  
    validates :title, :content, :user_id, presence: true
    validates :answers_count, :likes_count, numericality: { greater_than_or_equal_to: 0 }
  
    after_validation :ensure_created_at_has_a_value
  
    private
  
    def ensure_created_at_has_a_value
      self.created_at ||= Date.current
    end
end
