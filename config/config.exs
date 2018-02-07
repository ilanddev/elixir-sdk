# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :iland, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:iland, :key)
#
# Or configure a 3rd-party app:
#
config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
config :iland, api_base_url: "https://api.ilandcloud.com/ecs"
config :iland, access_url: "https://console.ilandcloud.com/auth/realms/iland-core/protocol/openid-connect/token"
config :iland, new_token_grant: "password"
config :iland, refresh_token_grant: "refresh_token"
config :iland, refresh_url: "https://console.ilandcloud.com/auth/realms/iland-core/protocol/openid-connect/token"
config :iland, accept_type: "application/vnd.ilandcloud.api.v0.9+json"
config :iland, content_type: "application/vnd.ilandcloud.api.v0.9+json"
config :iland, client_id: System.get_env("ILAND_CLIENT_ID")
config :iland, client_secret: System.get_env("ILAND_CLIENT_SECRET")
config :iland, username: System.get_env("ILAND_USERNAME")
config :iland, password: System.get_env("ILAND_PASSWORD")
