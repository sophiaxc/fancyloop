class Revision < ActiveRecord::Base
  attr_accessible :image, :caption
  validates :project_id, presence: true
  validates :caption, length: { maximum: 140 }

  belongs_to :project

  default_scope order: 'revisions.created_at DESC'

  has_attached_file :image, {
    :storage => :s3,
    :bucket => ENV['FANCYLOOP_S3_BUCKET_NAME'],
    :s3_credentials => {
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    },
    :styles => {
      :large => "850x",
      :thumb => "300x300",
    },
    :path => "revisions/images/:id/:style/:hash.:extension",
    :hash_secret => ENV['FANCYLOOP_HASH'],
  }

  validates_attachment :image, presence: true,
    :content_type => {
        :content_type => ["image/jpg", "image/x-png", "image/jpeg", "image/png"] },
        :size => { :in => 0..5.megabytes }
end
