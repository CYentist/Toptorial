module Admin::TutorialsHelper
  def render_tutorial_status(tutorial)
    if tutorial.checked
      "(已上架)"
    else
      "(待审核)"
    end
  end
end
