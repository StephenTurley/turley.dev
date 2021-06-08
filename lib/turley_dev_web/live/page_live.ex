defmodule TurleyDevWeb.PageLive do
  use TurleyDevWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, typing: false, msg: "")}
  end

  @impl true
  def handle_event("send_message", %{"msg" => msg}, socket) do
    IO.inspect(socket)
    {:noreply, assign(socket, msg: msg)}
  end

  @impl true
  def handle_event("typing", %{"msg" => msg}, socket) do
    IO.inspect(socket)
    {:noreply, assign(socket, typing: true, msg: msg)}
  end

  @impl true
  def handle_event("stopped_typing", _, socket) do
    IO.inspect(socket)
    {:noreply, assign(socket, typing: false)}
  end
end
