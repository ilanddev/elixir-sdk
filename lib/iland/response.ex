defmodule Iland.Response do

  require Logger

  @moduledoc """
  Functions for handling iland cloud API responses.  The responses are
  automatically sanitized from JSON hijacking prefixes.
  """
  
  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body |> strip_json_hijacking_prefix}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    Logger.error("error: " <> to_string(reason))
    {:error, reason}
  end

  def handle_response({_, %{status_code: _, body: body}}) do
    Logger.error("error: " <> to_string(body))
    {:error, body}
  end

  defp strip_json_hijacking_prefix(body) do
    cond do
     String.starts_with?(body, ")]}'\n") -> String.slice(body, 5..-1)
     true -> body
    end
  end

end
