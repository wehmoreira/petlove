FactoryBot.define do
  factory :person do
    nome { "Nome Teste da Silva" }
    documento { "%09d" % rand(999999999) }
    data_nascimento { Time.now.strftime("%Y-%m-%d") }

    factory :person_with_animals do
      transient do
        people_count { 5 }
      end
      after(:create) do |person, evaluator|
        create_list(:animal, evaluator.people_count, person: person)
      end
    end
  end
end
