json.array!(@denuncia) do |denuncium|
  json.extract! denuncium, :id, :data, :hora, :endereco, :descricao, :x, :y
  json.url denuncium_url(denuncium, format: :json)
end
