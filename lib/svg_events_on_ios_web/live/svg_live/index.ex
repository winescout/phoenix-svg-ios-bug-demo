defmodule SvgEventsOnIosWeb.SvgLive.Index do
  use SvgEventsOnIosWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket
      |> assign(:color, "pink")
    }
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("click_happened", _, socket) do
    {:noreply, socket
      |> assign(:color, "green")
    }
  end

  @impl true
  def render(assigns) do
    ~L"""
    <h1>SVG Click Demo of IOS bug.</h1>

    <p>This works fine in the browser, but click (press) events are not triggered on IOS.  Tested against simulator, and hardware</p>

    <svg height="250" width="500">
      <polygon 
        phx-click="click_happened"
        points="220,10 300,210 170,250 123,234" 
        style="fill:<%= @color %>;stroke:purple;stroke-width:1" 
      />
    </svg>
    """
  end
end
