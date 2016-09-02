defmodule IlandTest do
  use ExUnit.Case
  alias Iland.Api
  alias Iland.Response

  doctest Iland

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "get an iland url" do
    assert Api.iland_url("/user/testman") == Application.get_env(:iland, :api_base_url) <> "/user/testman"
  end

  test "handle 200" do
    assert Response.handle_response({:ok, %{status_code: 200, body: "hello"}}) == {:ok, "hello"}
  end

  test "handle 201" do
    assert Response.handle_response({:ok, %{status_code: 201, body: "hello"}}) == {:ok, "hello"}
  end

  test "handle 202" do
    assert Response.handle_response({:ok, %{status_code: 202, body: "hello"}}) == {:ok, "hello"}
  end

  test "handle 203" do
    assert Response.handle_response({:ok, %{status_code: 203, body: "hello"}}) == {:ok, "hello"}
  end

  test "handle 204" do
    assert Response.handle_response({:ok, %{status_code: 204, body: "hello"}}) == {:ok, "hello"}
  end

  test "handle 404 ok" do
    assert Response.handle_response({:ok, %{status_code: 404, body: "hello"}}) == {:error, "hello"}
  end

  test "handle 404 error" do
    assert Response.handle_response({:error, %{status_code: 404, body: "hello"}}) == {:error, "hello"}
  end

  test "handle HTTPoison error" do
    assert Response.handle_response({:error, %HTTPoison.Error{ reason: "httpoison reason"}}) == {:error, "httpoison reason"}
  end

  test "handle 200 with JSON hijacking prefix" do
    assert Response.handle_response({:ok, %{status_code: 200, body: ")]}'\nhello"}}) == {:ok, "hello"}
  end

end
