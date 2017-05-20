module TutorialsHelper
  def render_tutorial_image
    if @tutorial.image.present?
      @tutorial.image.thumb.url
    else
      "http://placehold.it/200x200&text=No Pic"
    end
  end


end
