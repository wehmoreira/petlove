require 'rails_helper'

describe Pessoa, type: :model do
  context 'validação' do
    subject { build(:pessoa) }
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
      it 'tem a formatação correta' do
        subject.data_nascimento = 'Lorem ipsum dolor sit amet'
        expect(saved).to eq(false)
      end
    end
  end
end
