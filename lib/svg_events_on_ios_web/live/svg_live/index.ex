defmodule SvgEventsOnIosWeb.SvgLive.Index do
  use SvgEventsOnIosWeb, :live_view

  alias SvgEventsOnIos.Demo
  alias SvgEventsOnIos.Demo.Svg

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :svgs, list_svgs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Svg")
    |> assign(:svg, Demo.get_svg!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Svg")
    |> assign(:svg, %Svg{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Svgs")
    |> assign(:svg, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    svg = Demo.get_svg!(id)
    {:ok, _} = Demo.delete_svg(svg)

    {:noreply, assign(socket, :svgs, list_svgs())}
  end

  defp list_svgs do
    Demo.list_svgs()
  end
end
