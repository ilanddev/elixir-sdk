# Iland

**An Elixir SDK for the iland cloud API.**

## Introduction

The iland cloud Elxiir SDK provides a wrapper around the
[iland cloud API](https://api.ilandcloud.com). This libary handles
token management as well as reponse handling.

[iland cloud](https://www.iland.com) provides Enterprise-grade IaaS and this
library is intended to make it even easier for Elixir programmers to use.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `iland` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:iland, "~> 0.1.0"}]
    end
    ```

  2. Ensure `iland` is started before your application:

    ```elixir
    def application do
      [applications: [:iland]]
    end
    ```

## Getting the code

The code is hosted at https://github.com/ilanddev/elixir-sdk

Check out the latest development version anonymously with:

```
git clone https://github.com/ilanddev/elixir-sdk
cd elixir-sdk
```


