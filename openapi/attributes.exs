defmodule Stripe.Attributes do
    def process(schemas) do
        keys = Map.keys(schemas)

        Enum.map(keys, fn(key) -> 
            value = %{}
            schema = Map.get(schemas, key)

            properties = Map.get(schema, "properties", %{})
            |> Enum.map(fn {k, v} -> 
                %{k, }
            end)

            %{}
            |> Map.put_new(:required, Map.get(schema, "required", []))
            |> Map.put_new(:properties, properties)
        end)
        |> IO.inspect
    end

    defp pick(%{})
  end