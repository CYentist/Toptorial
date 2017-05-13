module Account::TutorialsHelper
  def render_account_tutorial_status(tutorial)
    if tutorial.checked
      "(已上架)"
    else
      "(审核中)"
    end
  end
end
