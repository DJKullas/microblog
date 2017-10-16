defmodule MicroblogWeb.UpdatesChannel do
  use MicroblogWeb, :channel

  def join("updates:all", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("new_post", %{"fullName" => fullName, "handle" => handle, "messageText" => messageText}, socket) do
    broadcast! socket, "new_post", %{fullName: fullName, handle: handle, messageText: messageText}
    {:noreply, socket}
  end

  def handle_out("new_post", payload, socket) do
    push socket, "new_post", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
