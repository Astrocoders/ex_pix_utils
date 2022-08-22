defmodule ExPixUtils.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_pix_utils,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.8.4"},
      {:money, git: "https://github.com/georgelima/money"},
      {:ex_pix, git: "https://github.com/Astrocoders/ex_pix"}
    ]
  end
end
