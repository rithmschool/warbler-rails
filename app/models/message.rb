class Message < ApplicationRecord
  belongs_to :user
  validates :text, presence: true

  def date
    created_at.strftime('%d %B %Y')
  end
end
