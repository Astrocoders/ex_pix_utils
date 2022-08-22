defmodule ExPixUtils.Models.Pix do
  use ExPixUtils.Models.Base

  alias ExPixUtils.Models.Refund

  @required [:endToEndId, :valor, :horario]
  @optional [:txid, :chave, :infoPagador]

  embedded_schema do
    field(:endToEndId, :string)
    field(:txid, :string)
    field(:valor, ExPixUtils.Ecto.Money)
    field(:chave, :string)
    field(:horario, :utc_datetime)
    field(:infoPagador, :string)

    embeds_many(:devolucoes, Refund)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(coalesce_params(params), @required ++ @optional)
    |> cast_embed(:devolucoes, required: false, default: [])
    |> validate_required(@required)
  end

  defp coalesce_params(%{"devolucoes" => nil} = params),
    do: Map.put(params, "devolucoes", [])

  defp coalesce_params(%{devolucoes: nil} = params), do: Map.put(params, :devolucoes, [])
  defp coalesce_params(params), do: params
end
