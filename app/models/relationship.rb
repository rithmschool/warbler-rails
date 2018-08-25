class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followee, class_name: "User"
  validates :follower_id, presence: true
  validates :follower_id, presence: true
  validate :no_self_follow

  private

  def no_self_follow
    return if followee_id != follower_id
    errors.add(:no_self_follow, "Users can't follow themselves")
  end
end
