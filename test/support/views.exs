defmodule Coherence.CoherenceView do
  use Phoenix.HTML
  use Phoenix.View, root: "web/templates/coherence"
  import TestCoherence.Router.Helpers

  @seperator {:safe, "&nbsp; | &nbsp;"}

  def coherence_links(conn, :new_session) do
    user_schema = Coherence.Config.user_schema
    [
      recovery_link(conn, user_schema),
      unlock_link(conn, user_schema)
    ]
    |> List.flatten
    |> concat([])
  end

  defp concat([], acc), do: Enum.reverse(acc)
  defp concat([h|t], []), do: concat(t, [h])
  defp concat([h|t], acc), do: concat(t, [h, @seperator | acc])

  defp recovery_link(conn, user_schema) do
    if user_schema.recoverable? do
      [link("Forgot Your Password?", to: password_path(conn, :new))]
    else
      []
    end
  end

  defp unlock_link(conn, _user_schema) do
    if conn.assigns[:locked] do
      [link("Send an unlock email", to: unlock_path(conn, :new))]
    else
      []
    end
  end
end

defmodule Coherence.LayoutView do
  use Phoenix.HTML
  use Phoenix.View, root: "test/support/templates"
  # import TestCoherence.Router.Helpers

end
