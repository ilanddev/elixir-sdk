defmodule Iland.Api do

  require Logger
  alias Iland.{Response, Token}

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
  @default_accept_header %{
                            "Accept": @accept_type
                          }
  @default_headers %{
                      "Accept": @accept_type,
                      "Content-Type": @content_type
                    }

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
  def get(rel_path, headers \\ @default_accept_header) do
    request(:get, rel_path, headers)
  end

  @doc """
  Perform a POST request against the iland cloud API.
  """
  def post(rel_path, body \\ "", headers \\ @default_headers) do
    request(:post, rel_path, headers, body)
  end

  @doc """
  Perform a PUT request against the iland cloud API.
  """
  def put(rel_path, body \\ "", headers \\ @default_headers) do
    request(:put, rel_path, headers, body)
  end

  @doc """
  Perform a DELETE request against the iland cloud API.
  """
  def delete(rel_path, headers \\ @default_accept_header) do
    request(:delete, rel_path, headers)
  end

  @doc """
  Perform a HTTP request against the iland cloud API, using the supplied
  HTTP method, headers, and options.
  """
  def request(method, rel_path, headers \\ @default_headers, body \\ "", opts \\ []) do
    url = iland_url(rel_path)
    Logger.info "#{String.upcase(to_string(method))} to #{url}"
    headers = headers |> add_auth_header
    method
    |> HTTPoison.request(url, body, headers, opts)
    |> Response.handle_response
  end

  @doc """
  Add authorization header, to the given list of headers.
  """
  def add_auth_header(headers \\ %{}) do
    Map.put(headers, "Authorization", "Bearer " <> Token.get.access_token)
  end

end
