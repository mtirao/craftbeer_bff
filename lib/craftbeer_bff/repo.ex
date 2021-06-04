defmodule CraftbeerBff.Repo do
  use Ecto.Repo,
    otp_app: :craftbeer_bff,
    adapter: Ecto.Adapters.Postgres
end
