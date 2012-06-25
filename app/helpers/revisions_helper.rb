module RevisionsHelper
   def full_title(revision)
    revisions = revision.project.revisions
    hash = Hash[revisions.map.with_index{|*ki| ki}]  
    version = revisions.length - hash[revision]
    base_title = revision.project.title
    "#{base_title} | Version #{version}"
  end
end
