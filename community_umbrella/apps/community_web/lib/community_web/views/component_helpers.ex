defmodule CommunityWeb.ComponentHelpers do
  def c(template, assigns) do
    CommunityWeb.ComponentsView.render(template, assigns)
  end

  def c(template, assigns, do: block) do
    CommunityWeb.ComponentsView.render(template, Keyword.merge(assigns, [do: block]))
  end

  def btn(:primary, do: block) do
    c("button_primary.html", [], do: block)
  end

  def btn(:primary, label: label) do
    c("button_primary.html", [do: label])
  end

end
