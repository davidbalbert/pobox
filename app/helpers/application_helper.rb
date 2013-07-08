module ApplicationHelper
  def title(value = nil)
    if value
      content_for(:title) { value }
    else
      content_for(:title)
    end
  end
end
