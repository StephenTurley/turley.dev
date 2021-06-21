defmodule TurleyDevWeb.PageLive do
  use TurleyDevWeb, :live_view
  alias TurleyDev.Timeline
  alias TurleyDev.Accounts

  @impl true
  def mount(_params, session, socket) do
    if connected?(socket), do: Timeline.subscribe()
    posts = Timeline.get_all()

    user =
      Map.get(session, "user_token")
      |> Accounts.get_user_by_session_token()

    {:ok, assign(socket, user: user, content: "", posts: posts)}
  end

  @impl true
  def handle_event("create_post", %{"content" => content}, socket) do
    IO.inspect(socket)
    Timeline.create_text_post(socket.assigns.user, content)

    {:noreply, assign(socket, content: "", posts: Timeline.get_all())}
  end

  @impl true
  def handle_info({:post_added, %{"post" => _post}}, socket) do
    {:noreply, assign(socket, posts: Timeline.get_all())}
  end
end
