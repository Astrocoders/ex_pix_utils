defmodule ExPixUtils.Models.DynamicPixCharge.Calendar do
  @required [:criacao]
  @optional [:expiracao]

  use ExPixUtils.Models.Base

  embedded_schema do
    field(:criacao, :utc_datetime)
    field(:expiracao, :integer, default: 86_400)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end
end
