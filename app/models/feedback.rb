class Feedback < ActiveRecord::Base
  attr_accessible :comment, :author

  validates :comment, presence: true, length: { maximum: 250 }
  validates :author,  presence: true, length: { maximum: 50 }
  validates :revision_id, presence: true

  belongs_to :revision

  default_scope order: 'feedbacks.created_at DESC'
end
