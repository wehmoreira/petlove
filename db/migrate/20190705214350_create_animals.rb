class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string :nome
      t.decimal :custo_mensal, precision: 10, scale: 2
      t.string :tipo
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
