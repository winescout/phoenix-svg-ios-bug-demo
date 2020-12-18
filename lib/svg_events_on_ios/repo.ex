defmodule SvgEventsOnIos.Repo do
  use Ecto.Repo,
    otp_app: :svg_events_on_ios,
    adapter: Ecto.Adapters.Postgres
end
