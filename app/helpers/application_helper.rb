module ApplicationHelper
  def title(value = nil)
    if value
      content_for(:title) { value }
    else
      content_for(:title)
    end
  end

  def error_list(object)
    if object.errors.any?
      content_tag("ul", class: "form-errors") do
        object.errors.full_messages.map do |e|
          content_tag("li", e)
        end.join(" ").html_safe
      end
    end
  end
end
