import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :form_examples, FormExamplesWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Z2ZThCCeKylHQO0WXriLj8SbfF+Tz0Dk6ie+Rr54C0+vSMuzWL3wwXuUyNMNfWTa",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
