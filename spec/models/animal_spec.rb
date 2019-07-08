require 'rails_helper'

describe Animal, type: :model do
  context 'validações' do
    let(:person) { create(:person) }
    subject { build(:animal, person_id: person.id) }
    let(:saved) { subject.save }
    context 'nome' do
      it 'não pode ser vazio' do
        subject.nome = ''
        expect(saved).to eq(false)
      end
    end
    context 'custo mensal' do
      it 'não pode ser vazio' do
        subject.custo_mensal = ''
        expect(saved).to eq(false)
      end
      it 'deve ser número' do
        subject.custo_mensal = 'Lorem'
        expect(saved).to eq(false)
      end
      it 'deve ser positivo' do
        subject.custo_mensal = '-12'
        expect(saved).to eq(false)
      end
      it 'deve arredondar caso tenha mais de duas casas decimais' do
        subject.custo_mensal = '5.109'
        expect(saved).to eq(true)
        expect(subject.custo_mensal).to eq(5.11)
      end
      it 'deve aceitar valores com vírgula' do
        subject.custo_mensal = '5,109'
        expect(saved).to eq(true)
        expect(subject.custo_mensal).to eq(5.11)
      end
      it 'não deve incluir mais um animal se o dono tiver custos com animais acima de 1000' do
        subject.person = create(:person)
        subject.person.animals << create(:animal, custo_mensal: 999.99)
        expect(saved).to eq(false)
      end
    end
    context 'tipo' do
      it 'não pode ser vazio' do
        subject.tipo = ''
        expect(saved).to eq(false)
      end
      context 'Andorinhas' do
        before { subject.tipo = 'Andorinha' }
        it 'não podem ter donos menores de 18 anos' do
          subject.person = create(:person, data_nascimento: 18.years.ago + 1.day)
          expect(saved).to eq(false)
        end
        it 'podem ter donos maiores de 18 anos' do
          subject.person = create(:person, data_nascimento: 18.years.ago)
          expect(saved).to eq(true)
        end
      end
      context 'Gatos' do
        before { subject.tipo = 'Gato' }
        it 'não podem ter donos com nome começando com `A`' do
          subject.person = create(:person, nome: 'Adalberto')
          expect(saved).to eq(false)
        end
        it 'podem ter donos com nome começando com qualquer outra letra' do
          subject.person = create(:person, nome: 'Eustácio')
          expect(saved).to eq(true)
        end
      end
    end
  end
end
