# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  tutorial_id :integer
#  user_id     :integer
#  post        :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Comment < ApplicationRecord
  belongs_to :tutorial
  belongs_to :user
  validates :post, presence: true
end
