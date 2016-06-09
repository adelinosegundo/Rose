class CreateDenuncia < ActiveRecord::Migration
  def change
    create_table :denuncia do |t|
      t.string :data
      t.string :hora
      t.string :endereco
      t.string :descricao
      t.int :x
      t.int :y

      t.timestamps null: false
    end
  end
end
