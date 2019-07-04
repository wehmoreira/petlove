class CreatePessoas < ActiveRecord::Migration[5.2]
  def change
    create_table :pessoas do |t|
      t.string :nome
      t.string :documento
      t.date :data_nascimento

      t.timestamps
    end
  end
end
