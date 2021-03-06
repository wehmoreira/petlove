require 'rails_helper'

describe Person, type: :model do
  context 'validação' do
    subject { build(:person) }
    let(:saved) { subject.save }
    context 'nome' do
      it 'deve conter o campo `nome`' do
        subject.nome = ''
        expect(saved).to eq(false)
      end
    end
    context 'documento' do
      it 'deve conter o campo `documento`' do
        subject.documento = ''
        expect(saved).to eq(false)
      end
    end
    context 'data_nascimento' do
      it 'deve conter o campo `data_nascimento`' do
        subject.data_nascimento = ''
        expect(saved).to eq(false)
      end
      it 'deve ser uma data válida' do
        subject.data_nascimento = 'Lorem ipsum dolor sit amet'
        expect(saved).to eq(false)
      end
    end
  end
end
