# == Schema Information
#
# Table name: tutorials
#
#  id          :integer          not null, primary key
#  title       :string
#  content     :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  checked     :boolean          default("f")
#  description :text
#  image       :string
#  price       :integer
#

require 'test_helper'

class TutorialTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
