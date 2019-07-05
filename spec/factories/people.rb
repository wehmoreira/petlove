FactoryBot.define do
  factory :person do
    nome { "Nome Teste da Silva" }
    documento { "%09d" % rand(999999999) }
    data_nascimento { Time.now.strftime("%Y-%m-%d") }
  end
end
