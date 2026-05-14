json.array!(@empleados) do |empleado|
  json.extract! empleado, :id, :identificacion, :nombre, :cargo, :estado, :instructor
  json.url empleado_url(empleado, format: :json)
end
