class Order < ApplicationRecord
before_create :generate_token

  def generate_token
    self.token = SecureRandom.uuid
  end
  belongs_to :user
  belongs_to :answers
  has_many :order_relationships
  has_many :askers, :through => :order_relationships, source: :user

  validates :question, presence: true
  validates :contact, presence: true

  include AASM

    aasm do
      state :order_placed, initial: true
      state :order_accepted
      state :finished
      state :order_cancelled




      event :accept do
        transitions from: :order_placed,         to: :order_accepted
      end

      event :deliver do
        transitions from: :order_accepted,     to: :finished
      end

      event :cancel_order do
        transitions from: :order_placed,       to: :order_cancelled
      end
    end
end
