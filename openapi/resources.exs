defmodule Stripe.Resources do
  def process(raw) do
    # x = Map.fetch(raw, "paths")

    # File.write!("tmp.ex", :erlang.term_to_binary(raw))
    endpoints = Map.keys(paths)

    Enum.each([Enum.at(endpoints, 0)], fn(path) -> 
      operations = 
        Map.get(paths, path)
      
      for {type, spec} <- operations do
        %{"operationId" => operationId, "description" => description, "parameters" => parameters } = spec

        context = %{
          endpoint: path,
          module_name: operationId,
          description: description,
          actions: [%{
            method: type,
            function_name: "list"
          }]
        }
        rendered = EEx.eval_file("priv/template.ex.eex", context: context)

        # File.write("spec3.ex", [Code.format_string!(rendered), ?\n])
      end
    end)
  end
end