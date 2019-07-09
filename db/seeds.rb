# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

people = [
  [ 'Johnny Cash', '555555555', '1932-02-26' ],
  [ 'Sid Vicious', '555555555', '1957-05-10' ],
  [ 'Axl Rose', '555555555', '1962-02-06' ],
  [ 'Joey Ramone', '555555555', '1951-05-19' ],
  [ 'Bruce Dickinson', '555555555', '1958-08-07' ],
  [ 'Kurt Cobain', '555555555', '1967-02-20' ],
  [ 'Elvis Presley', '555555555', '2008-08-17' ]
]
people.each do |nome, documento, data_nascimento|
  Person.create(nome: nome, documento: documento, data_nascimento: data_nascimento)
end

animals = [
  [ 'Pé de Pano', '199,99', 'Cavalo', 'Johnny Cash' ],
  [ 'Rex', '99,99', 'Cachorro', 'Sid Vicious' ],
  [ 'Ajudante do Papai Noel', '99,99', 'Cachorro', 'Axl Rose' ],
  [ 'Rex', '103,99', 'Papagaio', 'Joey Ramone' ],
  [ 'Flora', '103,99', 'Lhama', 'Bruce Dickinson' ],
  [ 'Dino', '177,99', 'Iguana', 'Kurt Cobain' ],
  [ 'Lassie', '407,99', 'Ornitorrinco', 'Elvis Presley' ]
]
animals.each do |nome, custo_mensal, tipo, dono|
  Person.find_by_nome(dono).animals.create(nome: nome, custo_mensal: custo_mensal, tipo: tipo)
end
