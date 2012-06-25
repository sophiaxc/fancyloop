module RevisionsHelper
   def full_title(revision)
    base_title = revision.project.title
    "#{base_title} | Version #{get_version(revision)}"
  end

   def get_version(revision)
    revisions = revision.project.revisions
    hash = Hash[revisions.map.with_index{|*ki| ki}]  
    version = revisions.length - hash[revision]
   end

  def revision_photo_for(revision, options = { size: :thumb})
    size = options[:size]
    image = revision.image.url(size)
    image_tag(image, alt: revision.project.title, class: "revision_photo")
  end
end
