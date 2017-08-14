# Iland

**An Elixir SDK for the iland cloud API.**

![build status](http://img.shields.io/travis/ilanddev/elixir-sdk/master.svg?style=flat)
[![Coverage Status](https://coveralls.io/repos/github/ilanddev/elixir-sdk/badge.svg?branch=master)](https://coveralls.io/github/ilanddev/elixir-sdk?branch=master)
![license](http://img.shields.io/hexpm/l/iland.svg?style=flat)
![version](http://img.shields.io/hexpm/v/iland.svg?style=flat)
![downloads](http://img.shields.io/hexpm/dt/iland.svg?style=flat)

## Introduction

The iland cloud Elxiir SDK provides a wrapper around the
[iland cloud API](https://api.ilandcloud.com). This libary handles
token management as well as reponse handling.

[iland cloud](https://www.iland.com) provides Enterprise-grade IaaS and this
library is intended to make it even easier for Elixir programmers to use.

## Installation

  The iland package is available on [Hex](https://hex.pm/packages/iland)

  1. Add `iland` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:iland, "~> 0.1.7"}]
    end
    ```

  2. Ensure `iland` is started before your application:

    ```elixir
    def application do
      [applications: [:iland]]
    end
    ```

  3. Run `$ mix deps.get`

## Getting the code

The code is hosted at https://github.com/ilanddev/elixir-sdk

Check out the latest development version anonymously with:

```
$ git clone https://github.com/ilanddev/elixir-sdk
$ cd elixir-sdk
```


