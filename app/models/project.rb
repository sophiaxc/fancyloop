# == Schema Information
#
# Table name: projects
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Project < ActiveRecord::Base
  attr_accessible :title
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }

  belongs_to :user
  has_many :revisions, dependent: :destroy

  default_scope order: 'projects.created_at DESC'
end
