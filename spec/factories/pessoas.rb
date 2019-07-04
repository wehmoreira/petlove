FactoryBot.define do
  factory :pessoa do
    nome { "Nome Teste da Silva" }
    documento { "555555" }
    data_nascimento { "2019-07-03" }
  end
end
