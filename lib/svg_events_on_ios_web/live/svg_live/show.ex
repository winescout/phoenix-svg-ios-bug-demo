defmodule SvgEventsOnIosWeb.SvgLive.Show do
  use SvgEventsOnIosWeb, :live_view

  alias SvgEventsOnIos.Demo

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:svg, Demo.get_svg!(id))}
  end

  defp page_title(:show), do: "Show Svg"
  defp page_title(:edit), do: "Edit Svg"
end
