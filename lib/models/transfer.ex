defmodule ExPixUtils.Models.Transfer do
  use ExPixUtils.Models.Base

  @required [:id, :e2eId, :valor, :status]

  embedded_schema do
    field(:id, :string)
    field(:e2eId, :string)
    field(:valor, ExPixUtils.Ecto.Money)

    embeds_one :horario, Calendar, primary_key: false do
      field(:solicitacao, :utc_datetime)
    end

    # EM_PROCESSAMENTO / REALIZADO / NAO_REALIZADO
    field(:status, :string)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> cast_embed(:horario, required: true, with: &calendar_changeset/2)
    |> validate_required(@required)
  end

  defp calendar_changeset(model, params),
    do:
      model
      |> cast(params, [:solicitacao])
end
