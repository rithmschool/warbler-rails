class Message < ApplicationRecord
  belongs_to :user

  def date
    created_at.strftime('%d %B %Y')
  end
end
