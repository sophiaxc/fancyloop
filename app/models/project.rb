class Project < ActiveRecord::Base
  attr_accessible :title
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }

  belongs_to :user
  has_many :revisions, dependent: :destroy

  default_scope order: 'projects.created_at DESC'
end
