defmodule ExPixUtils.Models.DynamicPixCharge.Payer do
  @required [:nome]
  @optional [:cpf, :cnpj]

  use ExPixUtils.Models.Base

  embedded_schema do
    field(:nome, :string)
    field(:cpf, :string)
    field(:cnpj, :string)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required ++ @optional)
    |> validate_required(@required)
  end
end
