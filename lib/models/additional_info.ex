defmodule ExPixUtils.Models.AdditionalInfo do
  @required [:nome, :valor]

  use ExPixUtils.Models.Base

  embedded_schema do
    field(:nome, :string)
    field(:valor, :string)
  end

  def changeset(model \\ %__MODULE__{}, params) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
  end
end
