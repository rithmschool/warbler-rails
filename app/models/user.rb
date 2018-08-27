class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable

  has_many :messages, dependent: :destroy
  has_many :follower_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
  has_many :followee_relationships, class_name: "Relationship",
                                    foreign_key: "followee_id",
                                    dependent: :destroy

  has_many :followers, through: :followee_relationships, source: :follower
  has_many :following, through: :follower_relationships, source: :followee

  before_validation { self.image_url = "/images/default-pic.png" if image_url.blank? }

  def follow(user)
    following << user
  end

  def unfollow(user)
    following.delete(user)
  end

  def is_following?(user)
    following.include?(user)
  end

  def is_followed_by?(user)
    followers.include?(user)
  end

  def most_recent_messages
    messages.order(created_at: :desc)
  end

end
