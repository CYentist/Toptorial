class Comment < ApplicationRecord
  belongs_to :tutorial
  belongs_to :user
  validates :post, presence: true
end
