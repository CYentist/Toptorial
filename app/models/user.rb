# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  is_admin               :boolean          default("f")
#  point                  :integer          default("0")
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tutorials
  has_many :tutorial_relationships
  has_many :paid_tutorials, :through => :tutorial_relationships, :source => :tutorial
  has_many :comments
  mount_uploader :avatar, ImageUploader

  def admin?
    is_admin
  end

  def is_buyer?(tutorial)
    paid_tutorials.include?(tutorial)
  end

  def buy!(tutorial)
    paid_tutorials << tutorial
  end

  def display_name
    if self.username.present?
      self.username
    else
      self.email.split("@").first
    end
  end
  # 如果没有用户名的时候显示 email

  def total_votes
    sum = 0
    tutorials.each do |tutorial|
      if tutorial.present?
        sum += tutorial.cached_votes_up
      end
    end
    sum
  end
end
