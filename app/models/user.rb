class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    validates :name, :email, :password, presence: true
    validates :email, format: {with: /\A(.+)@(.+)\z/, message: "Email invalid"}, uniqueness: true
    validates :password, length: {minimum: 6}
    has_many :posts
end
