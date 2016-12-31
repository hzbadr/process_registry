# Chat

** Following this article
https://m.alphasights.com/process-registry-in-elixir-a-practical-example-4500ee7c0dcc#.yhtj6api7

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `chat` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:chat, "~> 0.1.0"}]
    end
    ```

  2. Ensure `chat` is started before your application:

    ```elixir
    def application do
      [applications: [:chat]]
    end
    ```
