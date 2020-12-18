defmodule SvgEventsOnIosWeb.Router do
  use SvgEventsOnIosWeb, :router
  alias SvgLive

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SvgEventsOnIosWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SvgEventsOnIosWeb do
    pipe_through :browser
    live "/", SvgLive.Index, :index
  end
end
