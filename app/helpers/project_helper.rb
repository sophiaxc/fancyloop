module ProjectHelper
  # Returns the primary photo for the given grampost.
  def project_photo_for(project, options = { size: :thumb,
                                             class: "project_photo"})
    if project.revisions.any?
      size = options[:size]
      image = project.revisions.first.image.url(size)
    else
      image = "no_revisions.png"
    end
    image_tag(image, alt: project.title, class: options[:class])
  end
end
