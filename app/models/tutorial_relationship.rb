# == Schema Information
#
# Table name: tutorial_relationships
#
#  id          :integer          not null, primary key
#  tutorial_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TutorialRelationship < ApplicationRecord
  belongs_to :user
  belongs_to :tutorial
end
