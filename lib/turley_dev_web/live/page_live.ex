defmodule TurleyDevWeb.PageLive do
  use TurleyDevWeb, :live_view
  alias TurleyDev.Timeline
  alias TurleyDev.Accounts
  alias TurleyDev.Accounts.User

  @impl true
  def mount(_params, session, socket) do
    with user = %User{} <- current_user(session),
         posts <- Timeline.get_all() do
      if connected?(socket), do: Timeline.subscribe()
      {:ok, assign(socket, user: user, content: "", posts: posts)}
    end
  end

  @impl true
  def handle_event("create_post", %{"content" => content}, socket) do
    Timeline.create_text_post(socket.assigns.user, content)
    {:noreply, assign(socket, content: "", posts: Timeline.get_all())}
  end

  @impl true
  def handle_info({:post_added, %{"post" => _post}}, socket) do
    {:noreply, assign(socket, posts: Timeline.get_all())}
  end

  defp current_user(session) do
    session
    |> Map.get("user_token")
    |> Accounts.get_user_by_session_token()
  end
end
