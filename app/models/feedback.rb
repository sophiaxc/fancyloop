# == Schema Information
#
# Table name: feedbacks
#
#  id          :integer         not null, primary key
#  comment     :string(255)
#  author      :string(255)
#  user_id     :integer
#  revision_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Feedback < ActiveRecord::Base
  attr_accessible :comment, :author

  validates :comment, presence: true, length: { maximum: 250 }
  validates :author,  presence: true, length: { maximum: 50 }
  validates :revision_id, presence: true

  belongs_to :revision

  default_scope order: 'feedbacks.created_at DESC'
end
