defmodule Sicktix.Util do
  def convert_ecto(structs) when is_list(structs), do: Enum.map(structs, &convert_ecto/1)

  def convert_ecto(struct) when is_struct(struct) do
    struct
    |> Map.from_struct()
    |> Map.delete(:__meta__)
  end
end
