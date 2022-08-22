defmodule ExPixUtils.Models.DynamicPixCharge do
  @moduledoc """
  Dynammic pix charge ('cob' type)
  """

  use ExPixUtils.Models.Base

  alias ExPixUtils.Models.{AdditionalInfo, Pix}
  alias ExPixUtils.Models.DynamicPixCharge.{Calendar, Payer, Amount}

  @required [:revisao, :chave, :txid, :status]
  @optional [:solicitacaoPagador, :location, :pixCopiaECola]

  embedded_schema do
    field(:revisao, :integer)
    field(:chave, :string)
    field(:txid, :string)

    # ATIVA / CONCLUIDA / REMOVIDA_PELO_USUARIO_RECEBEDOR / REMOVIDA_PELO_PSP
    field(:status, :string)

    field(:solicitacaoPagador, :string)
    field(:location, :string)
    field(:pixCopiaECola, :string)

    embeds_one(:calendario, Calendar)
    embeds_one(:devedor, Payer)
    embeds_one(:valor, Amount)

    embeds_many(:infoAdicionais, AdditionalInfo)
    embeds_many(:pix, Pix)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(coalesce_params(params), @required ++ @optional)
    |> cast_embed(:calendario, required: true)
    |> cast_embed(:devedor, required: false)
    |> cast_embed(:infoAdicionais, required: false, default: [])
    |> cast_embed(:valor, required: true)
    |> cast_embed(:pix, required: false, default: [])
  end

  defp coalesce_params(%{"infoAdicionais" => nil} = params),
    do: Map.put(params, "infoAdicionais", [])

  defp coalesce_params(%{infoAdicionais: nil} = params), do: Map.put(params, :infoAdicionais, [])
  defp coalesce_params(params), do: params
end
