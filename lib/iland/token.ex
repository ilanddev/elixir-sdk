defmodule Iland.Token do

  require Logger

  @moduledoc """
  Handles iland cloud API authorization token retrieval and management.

  The module performs auto-refresh of the given token based on
  the token expiration time.
  """

  @token_url Application.get_env(:iland, :access_url)
  @refresh_url Application.get_env(:iland, :refresh_url)
  @client_id Application.get_env(:iland, :client_id)
  @client_secret Application.get_env(:iland, :client_secret)
  @username Application.get_env(:iland, :username)
  @password Application.get_env(:iland, :password)
  @new_token_grant Application.get_env(:iland, :new_token_grant)
  @refresh_token_grant Application.get_env(:iland, :refresh_token_grant)
  # 10 second token expiration buffer
  @buffer 10

  @derive [Poison.Encoder]
  defstruct [:access_token, :expires_in, :expires_at, :refresh_token]

  def start_link do
    Agent.start_link(fn -> nil end, [name: __MODULE__])
  end

  @doc """
  Get an iland cloud API authorization token.
  """
  def get do
    old_token = Agent.get(__MODULE__, fn(token) -> token end)
    if old_token == nil do
      replace_token
    else
      expire = old_token.expires_at
      cond do
        Timex.before?(Timex.shift(Timex.now, minutes: 5), expire) -> old_token
        Timex.before?(Timex.now, expire) -> refresh_token(old_token)
        true -> replace_token
      end
    end
  end

  defp replace_token do
    token = get_new_token
    Agent.get_and_update(__MODULE__, fn(_) -> {token, token} end)
  end

  defp get_new_token do
    Logger.info "requesting new iland API token"
    form = [client_id: @client_id,
            client_secret: @client_secret,
            username: @username,
            password: @password,
            grant_type: @new_token_grant,
            "Content-type": "application/x-www-form-urlencoded"]
    HTTPoison.post(@token_url, {:form, form})
    |> Iland.Response.handle_response
    |> extract_token
    |> add_token_expiration
  end

  defp add_token_expiration(token) do
    expires_at = Timex.now
                 |> Timex.shift(seconds: token.expires_in - @buffer)
    %{token | expires_at: expires_at}
  end

  defp refresh_token(token) do
    form = [client_id: @client_id,
            client_secret: @client_secret,
            grant_type: @refresh_token_grant,
            refresh_token: token.refresh_token,
            "Content-type": "application/x-www-form-urlencoded"]
    Logger.info "refreshing iland API token"
    refreshed = HTTPoison.post(@refresh_url, {:form, form})
            |> Iland.Response.handle_response
            |> extract_token
            |> add_token_expiration
    Agent.get_and_update(__MODULE__, fn(_token) -> {refreshed, refreshed} end)
  end

  defp extract_token(response) do
    elem(response, 1)
    |> Poison.decode!(as: %Iland.Token{})
  end

end
