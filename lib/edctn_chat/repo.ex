defmodule EdctnChat.Repo do
  use Ecto.Repo,
    otp_app: :edctn_chat,
    adapter: Ecto.Adapters.Postgres
end
