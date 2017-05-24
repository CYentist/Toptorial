class Order < ApplicationRecord
  belongs_to :user
  has_many :answers

  validates :question, presence: true
  validates :contact, presence: true
end
