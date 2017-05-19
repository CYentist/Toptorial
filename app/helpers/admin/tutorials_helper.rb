module Admin::TutorialsHelper
  def render_tutorial_status(tutorial)
    if tutorial.checked
      content_tag(:span, "已上架", :class => "label label-success")
    else
      content_tag(:span, "待审核", :class => "label label-warning")
    end
  end
end
