defmodule Stripe.FetchSpec do
  alias Req

  def save_spec() do
    version = get_latest_openapi_spec_tag()

    input = Req.get!("https://raw.githubusercontent.com/stripe/openapi/#{version}/openapi/spec3.sdk.json").body
    |> Jason.Formatter.pretty_print()

    File.cd!("openapi")
    File.write!("spec3.sdk.json", input, [:binary])
    File.cd!("..")

    input
  end

  defp get_latest_openapi_spec_tag() do
    Req.get!("https://api.github.com/repos/stripe/openapi/releases/latest", headers: [user_agent: "stripe-elixir"]).body["tag_name"]
  end

  defp get_current_openapi_spec_tag() do
    Req.get!("https://api.github.com/repos/stripe/openapi/releases/latest").body["tag_name"]
  end
end