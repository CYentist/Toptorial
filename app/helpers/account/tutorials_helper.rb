module Account::TutorialsHelper
  def render_account_tutorial_status(tutorial)
    if tutorial.checked
      content_tag(:span, "已上架", :class => "label label-success")
    else
      content_tag(:span, "审核中", :class => "label label-warning")
    end
  end

  def render_account_show_tutorial_status(tutorial)
    if tutorial.checked
      content_tag(:span, "该教程已上架", :class => "label label-success")
    else
      content_tag(:span, "该教程正在审核中", :class => "label label-warning")
    end
  end
end
