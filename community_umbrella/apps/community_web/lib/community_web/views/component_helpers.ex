defmodule CommunityWeb.ComponentHelpers do
  def c(template, assigns) do
    CommunityWeb.ComponentsView.render(template, assigns)
  end

  def c(template, assigns, do: block) do
    CommunityWeb.ComponentsView.render(template, Keyword.merge(assigns, [do: block]))
  end

  def btn(:primary, assigns, do: block) do
    c("button_primary.html", assigns, do: block)
  end

  def btn(:primary, do: block) do
    c("button_primary.html", [], do: block)
  end

  def btn(:primary, assigns) do
    label = assigns[:label]
    c("button_primary.html", assigns, do: label)
  end

end
