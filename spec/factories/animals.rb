FactoryBot.define do
  factory :animal do
    nome { "Petname" }
    custo_mensal { rand(100).to_s + ".%02d" % rand(100) }
    tipo { %w(Cavalo Cachorro Papagaio Andorinha Lhama Iguana Ornitorrinco).sample }
    person
  end
end
