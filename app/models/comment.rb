class Comment < ApplicationRecord
  belongs_to :message
  belongs_to :user
  has_many :reactions, as: :likeable,dependent: :destroy
  validates :content, presence: true

end
