Mix.install([
  {:req, "~> 0.3.2"},
  {:jason, "~> 1.1"}
])
  
[{fetch_spec, _}] = Code.require_file("fetch_spec.exs", "openapi/")
raw = fetch_spec.save_spec()

if !File.exists?("openapi/") do
  raise """
  Could not find the specification files under openapi
  """
end

if !File.dir?("priv") do
  raise """
  Template path "priv" could not be found.
  """
end

IO.puts("""
Generating code
""")


%{ "components" => %{ "schemas" => schemas }, "paths" => paths } = Jason.decode!(raw)

[{attributes, _}] = Code.require_file("attributes.exs", "openapi/")
schemas = attributes.process(schemas)

# [{resources, _}] = Code.require_file("resources.exs", "openapi/")
# resources_spec = resources.process(paths)
