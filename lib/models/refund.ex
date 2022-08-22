defmodule ExPixUtils.Models.Refund do
  use ExPixUtils.Models.Base

  @required [:id, :rtrId, :valor, :status]
  @optional [:natureza, :descricao, :motivo]

  embedded_schema do
    field(:id, :string)
    field(:rtrId, :string)
    field(:valor, ExPixUtils.Ecto.Money)

    embeds_one :horario, Calendar, primary_key: false do
      field(:solicitacao, :utc_datetime)
      field(:liquidacao, :utc_datetime)
    end

    # EM_PROCESSAMENTO / DEVOLVIDO / NAO_REALIZADO
    field(:status, :string)

    field(:natureza, :string)
    field(:descricao, :string)
    field(:motivo, :string)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(coalesce_params(params), @required ++ @optional)
    |> cast_embed(:horario, required: true, with: &calendar_changeset/2)
    |> validate_required(@required)
  end

  defp coalesce_params(%{"devolucoes" => nil} = params),
    do: Map.put(params, "devolucoes", [])

  defp coalesce_params(%{devolucoes: nil} = params), do: Map.put(params, :devolucoes, [])
  defp coalesce_params(params), do: params

  defp calendar_changeset(model, params),
    do:
      model
      |> cast(params, [:solicitacao, :liquidacao])
end
