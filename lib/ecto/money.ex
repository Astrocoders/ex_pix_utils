defmodule ExPixUtils.Ecto.Money do
  use Ecto.Type

  alias Money, as: ExMoney

  def type, do: :bigint

  def cast(amount) when is_binary(amount), do: parse_amount(amount)

  def cast(amount) when is_integer(amount), do: {:ok, Money.new(amount)}

  def cast(%ExMoney{} = amount), do: {:ok, amount}

  def cast(_), do: :error

  def load(data) when is_integer(data) do
    {:ok, Money.new(data)}
  end

  def dump(%ExMoney{amount: amount_in_cents}), do: {:ok, amount_in_cents}
  def dump(_), do: :error

  defp parse_amount(amount), do: ExMoney.parse(amount, :BRL, delimiter: ".", separator: "")
end
