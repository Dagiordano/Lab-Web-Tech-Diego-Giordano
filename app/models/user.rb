class User < ApplicationRecord
    validates :name, :email, :password, presence: true
    validates :email, format: {with: /\A(.+)@(.+)\z/, message: "Email invalid"}, uniqueness: true
    validates :password, length: {minimum: 6}
    has_many :posts
end
