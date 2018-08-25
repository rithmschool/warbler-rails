class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :messages
  has_many :follower_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
  has_many :followee_relationships, class_name: "Relationship",
                                    foreign_key: "followee_id",
                                    dependent: :destroy

  has_many :followers, through: :followee_relationships, source: :follower
  has_many :followees, through: :follower_relationships, source: :followee

  def follow(user)
    followees << user
  end

  def unfollow(user)
    followees.delete(user)
  end

  def is_following?(user)
    followees.include?(user)
  end

  def is_followed_by?(user)
    followers.include?(user)
  end

end
