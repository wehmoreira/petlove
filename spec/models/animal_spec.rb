require 'rails_helper'

describe Animal, type: :model do
  context 'validação' do
    subject { build(:animal) }
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
    end
    context 'tipo' do
      it 'não pode ser vazio' do
        subject.tipo = ''
        expect(saved).to eq(false)
      end
    end
  end
end
