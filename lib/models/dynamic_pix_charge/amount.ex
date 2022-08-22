defmodule ExPixUtils.Models.DynamicPixCharge.Amount do
  @required [:original]
  @optional [:modalidadeAlteracao]

  use ExPixUtils.Models.Base

  embedded_schema do
    field(:original, ExPixUtils.Ecto.Money)
    field(:modalidadeAlteracao, :integer, default: 0)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end
end
