defmodule TurleyDev.Repo do
  use Ecto.Repo,
    otp_app: :turley_dev,
    adapter: Ecto.Adapters.Postgres
end
