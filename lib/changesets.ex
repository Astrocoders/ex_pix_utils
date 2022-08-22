defmodule ExPixUtils.ValidationError do
  defexception [:message, :type, :changeset]
end

defmodule ExPixUtils.Changesets do
  import Ecto.Changeset
  alias Ecto.Changeset

  @spec cast_and_apply(schema_module :: module(), params :: map(), type :: atom()) ::
          {:ok, struct()} | {:error, {type :: atom, Changeset.t()}}
  def cast_and_apply(schema_module, params, type \\ :validation) do
    params
    |> schema_module.changeset()
    |> case do
      %{valid?: true} = changeset -> {:ok, apply_changes(changeset)}
      changeset -> {:error, {type, changeset}}
    end
  end

  @spec cast_and_apply!(schema_module :: module(), params :: map(), type :: atom()) ::
          struct()
  def cast_and_apply!(schema_module, params, type \\ :validation) do
    params
    |> schema_module.changeset()
    |> case do
      %{valid?: true} = changeset ->
        apply_changes(changeset)

      changeset ->
        raise ExPixUtils.ValidationError,
          message: "Validation error",
          type: type,
          changeset: changeset
    end
  end
end
