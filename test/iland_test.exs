defmodule IlandTest do
  use ExUnit.Case, async: false
  alias Iland.Api
  alias Iland.Response
  alias Iland.Token
  import Mock

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

  test "test get new token" do
    with_mock HTTPoison, [post: fn(_, _) -> {:ok, %{status_code: 200, body: "{\"expires_in\":900}"}} end] do
      token = Token.get
      # Tests that make the expected call
      assert token.expires_in == 900
    end
  end

  test "test api" do
    with_mocks([
      {HTTPoison,
       [],
       [request: fn(_,_,_,_,_) -> {:ok, %{status_code: 200, body: "body"}} end]},
      {Token,
       [],
       [get: fn() -> %Token{expires_in: 900, access_token: "fake_token"} end ]}
      ]) do
        assert Api.get("http://example.com") == {:ok, "body"}
        assert Api.put("http://example.com") == {:ok, "body"}
        assert Api.post("http://example.com") == {:ok, "body"}
        assert Api.delete("http://example.com") == {:ok, "body"}
    end
  end

  test "test refresh token" do
    with_mocks ([
      {HTTPoison,
        [],
        [post: fn(_, _) -> {:ok, %{status_code: 200, body: "{\"expires_in\":900}"}} end] },
      {Agent,
        [],
        [get: fn(_,_) -> %Token{expires_at: Timex.shift(Timex.now, minutes: 4)} end,
         get_and_update: fn(_,_) -> %Token{expires_in: 900} end]}
    ]) do
      token = Token.get
      # Tests that make the expected call
      assert token.expires_in == 900
    end
  end

end
