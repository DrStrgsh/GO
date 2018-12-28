class Post < ApplicationRecord
  validates :title, :summary, :body, presence: true
  belongs_to :user

end
