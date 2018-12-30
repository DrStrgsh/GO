class Post < ApplicationRecord
  validates :title, :summary, :body, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy
  is_impressionable
  acts_as_votable
  mount_uploader :image, ImageUploader
end
