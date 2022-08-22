defmodule ExPixUtils do
  defdelegate generate_static_code(
                key,
                static_params,
                account_params \\ %{},
                additional_params \\ %{}
              ),
              to: ExPIX
end
