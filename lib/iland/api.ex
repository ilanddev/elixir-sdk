defmodule Iland.Api do

  require Logger

  @moduledoc """
  Provides a basic API wrapper for accessing the iland cloud API.
  The package handles API token retrieval and renewal behind the scenes.
  There are methods for performing the following types of HTTP requests:
      GET
      POST
      PUT
      DELETE
  """

  @api_base_url Application.get_env(:iland, :api_base_url)
  @content_type Application.get_env(:iland, :content_type)
  @accept_type Application.get_env(:iland, :accept_type)

  @doc """
  Generates a absolute URL for the iland cloud API for the given
  relative URL.
  """
  def iland_url(rel_path) do
    @api_base_url <> rel_path
  end

  @doc """
  Performs a GET request against the iland cloud API.

  ## Examples
    iex(1)> Iland.Api.get("/user/testman")

    {:ok,
     "{\"deleted\":false,\"description\":\"\",\"fullname\":\"Test Man\",\"name\":\"testman\",\"vcloud_href\":\"https://man01.ilandcloud.com/api/admin/user/aaa7d338-7dbe-4aca-b903-69ad98fa4df9\",\"email\":\"fake@iland.com\",\"phone\":\"867-867-5309\",\"im\":\"\",\"type\":\"LDAP\",\"user_role_type\":\"ORGANIZATION\",\"active\":true,\"locked\":false,\"address\":\"\",\"company\":\"iland\",\"city\":\"\",\"state\":\"\",\"zip\":\"\",\"country\":\"United States\"}"}

  """
  def get(rel_path, accept_header \\ @accept_type) do
    request(:get, rel_path, accept_header)
  end

  @doc """
  Perform a POST request against the iland cloud API.
  """
  def post(rel_path, body \\ "", accept_header \\ @accept_type) do
    request(:post, rel_path, accept_header, body)
  end

  @doc """
  Perform a PUT request against the iland cloud API.
  """
  def put(rel_path, body \\ "", accept_header \\ @accept_type) do
    request(:put, rel_path, accept_header, body)
  end

  @doc """
  Perform a DELETE request against the iland cloud API.
  """
  def delete(rel_path, accept_header \\ @accept_type) do
    request(:delete, accept_header, rel_path)
  end

  @doc """
  Perform a HTTP request against the iland cloud API, using the supplied
  HTTP method, headers, and options.
  """
  def request(method, rel_path, accept_header \\ @accept_type, body \\ "", headers \\ [], opts \\ []) do
    url = iland_url(rel_path)
    Logger.info "#{String.upcase(to_string(method))} to #{url}"
    headers = headers |> add_headers
    headers = headers ++ [{"Accept", accept_header}]
    method
    |> HTTPoison.request(url, body, headers, opts)
    |> Iland.Response.handle_response
  end

  @doc """
  Add authorization, content-type and accept headers, to the given list of
  headers.
  """
  def add_headers(headers \\ []) do
    [
     {"Authorization", "Bearer " <> Iland.Token.get.access_token},
     {"Content-Type", @content_type}
    ] ++ headers
  end

end
