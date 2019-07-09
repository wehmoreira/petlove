# Desafio de código Backend Ruby

## Petlove

Petlove é um projeto de gestão de animais e seus respectivos donos!

## Subindo o sistema

O projeto foi feito usando Ruby 2.5.0, Rails 5.2.3, RVM (aqui, criei uma gemset) e banco de dados MySQL.
Também fiz BDD/TDD usando o RSpec.

Clone o repositório

```sh
$ git clone git@github.com:wehmoreira/petlove.git
```

Instale as dependências

```sh
$ cd petlove
$ gem install bundler
$ bundle install
```

Pronto! Agora é só rodar as migrações e subir o sistema no ar!
Pra rodar os testes

```sh
$ bundle exec rspec spec/ -cfd
```

## Questões

As questões devem ser respondidas com queries do `ActiveRecord`.
Inclua os trechos de código que respondem as perguntas abaixo:

### Qual é o custo médio dos animais do tipo cachorro?

```ruby
Animal.where(tipo: 'Cachorro').average(:custo_mensal).to_s
# => "99.99"
```

### Quantos cachorros existem no sistema?

```ruby
Animal.where(tipo: 'Cachorro').count
# => 2
```

### Qual o nome dos donos dos cachorros (Array de nomes)

```ruby
Animal.where(tipo: 'Cachorro').map { |animal| animal.person.nome }
# => ["Sid Vicious", "Axl Rose"]
```
ou (Eager Loading):

```ruby
Animal.includes(:person).where(tipo: 'Cachorro').map { |animal| animal.person.nome }
# => ["Sid Vicious", "Axl Rose"]
```

ou (usando join):

```ruby
Person.joins(:animals).where(animals: { tipo: 'Cachorro' }).map { |person| person.nome }
# => ["Sid Vicious", "Axl Rose"]
```

### Retorne as pessoas ordenando pelo custo que elas tem com os animais (Maior para menor)

no exemplo usado, com apenas um animal por dono:
```ruby
Person.joins(:animals).order(custo_mensal: :desc)
=begin
 => [#<Person:0x00007f8cd3e985d8
 id: 11,
  nome: "Elvis Presley",
  documento: "555555555",
  data_nascimento: Sun, 17 Aug 2008,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3e98448
  id: 5,
  nome: "Johnny Cash",
  documento: "555555555",
  data_nascimento: Fri, 26 Feb 1932,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3e982b8
  id: 10,
  nome: "Kurt Cobain",
  documento: "555555555",
  data_nascimento: Mon, 20 Feb 1967,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3e98088
  id: 8,
  nome: "Joey Ramone",
  documento: "555555555",
  data_nascimento: Sat, 19 May 1951,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3e93e20
  id: 9,
  nome: "Bruce Dickinson",
  documento: "555555555",
  data_nascimento: Thu, 07 Aug 1958,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3e93ab0
  id: 6,
  nome: "Sid Vicious",
  documento: "555555555",
  data_nascimento: Fri, 10 May 1957,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3e93768
  id: 7,
  nome: "Axl Rose",
  documento: "555555555",
  data_nascimento: Tue, 06 Feb 1962,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>]
=end
```
ou ordenando pela soma dos custos mensais de todos os animais da pessoa:

```ruby
Person.joins(:animals).group(:person_id).order('SUM(animals.custo_mensal) DESC')
=begin
=> [#<Person:0x00007f8cd3dd8c38
  id: 11,
  nome: "Elvis Presley",
  documento: "555555555",
  data_nascimento: Sun, 17 Aug 2008,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3dd89e0
  id: 5,
  nome: "Johnny Cash",
  documento: "555555555",
  data_nascimento: Fri, 26 Feb 1932,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3dd87b0
  id: 10,
  nome: "Kurt Cobain",
  documento: "555555555",
  data_nascimento: Mon, 20 Feb 1967,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3dd8530
  id: 8,
  nome: "Joey Ramone",
  documento: "555555555",
  data_nascimento: Sat, 19 May 1951,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3dd82d8
  id: 9,
  nome: "Bruce Dickinson",
  documento: "555555555",
  data_nascimento: Thu, 07 Aug 1958,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd3dd80d0
  id: 6,
  nome: "Sid Vicious",
  documento: "555555555",
  data_nascimento: Fri, 10 May 1957,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>,
 #<Person:0x00007f8cd6a83e90
  id: 7,
  nome: "Axl Rose",
  documento: "555555555",
  data_nascimento: Tue, 06 Feb 1962,
  created_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00,
  updated_at: Tue, 09 Jul 2019 14:56:22 UTC +00:00>]
=end
```

### Levando em consideração o custo mensal, qual será o custo de 3 meses de cada pessoa?

```ruby
Person.all.map { |person| [ person, (3 * person.animals.sum(:custo_mensal)).to_s ] }
=begin
=> [[#<Person:0x00007f8cd3ed1338
   id: 1,
   nome: "Johnny Cash",
   documento: "555555555",
   data_nascimento: Fri, 26 Feb 1932,
   created_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00,
   updated_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00>,
  "599.97"],
 [#<Person:0x00007f8cd3ed1180
   id: 2,
   nome: "Sid Vicious",
   documento: "555555555",
   data_nascimento: Fri, 10 May 1957,
   created_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00,
   updated_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00>,
  "299.97"],
 [#<Person:0x00007f8cd3ed0ed8
   id: 3,
   nome: "Axl Rose",
   documento: "555555555",
   data_nascimento: Tue, 06 Feb 1962,
   created_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00,
   updated_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00>,
  "299.97"],
 [#<Person:0x00007f8cd3ed0d70
   id: 4,
   nome: "Joey Ramone",
   documento: "555555555",
   data_nascimento: Sat, 19 May 1951,
   created_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00,
   updated_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00>,
  "311.97"],
 [#<Person:0x00007f8cd3ed0aa0
   id: 5,
   nome: "Bruce Dickinson",
   documento: "555555555",
   data_nascimento: Thu, 07 Aug 1958,
   created_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00,
   updated_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00>,
  "311.97"],
 [#<Person:0x00007f8cd3ed08e8
   id: 6,
   nome: "Kurt Cobain",
   documento: "555555555",
   data_nascimento: Mon, 20 Feb 1967,
   created_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00,
   updated_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00>,
  "533.97"],
 [#<Person:0x00007f8cd3ed0780
   id: 7,
   nome: "Elvis Presley",
   documento: "555555555",
   data_nascimento: Sun, 17 Aug 2008,
   created_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00,
   updated_at: Tue, 09 Jul 2019 19:26:40 UTC +00:00>,
  "1223.97"]]
=end
```
