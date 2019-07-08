require 'rails_helper'

describe 'gerenciamento de animais no sistema', type: :request do
  describe 'GET /people/:id' do
    before { get person_path(person.id) }
    context 'nenhum animal cadastrado para a pessoa' do
      let(:person) { create(:person) }
      it 'exibe uma mensagem' do
        expect(flash[:info]).to be_present
      end
    end
    context 'vários animais cadastrados para a pessoa' do
      let(:person) { create(:person_with_animals) }
      it 'exibe uma mensagem' do
        expect(flash[:info]).not_to be_present
      end
    end
  end
  describe 'POST /people/:person_id/animals' do
    before { allow(Person).to receive(:find).with(person.id.to_s).and_return(person) }
    let(:person) { create(:person) }
    let(:request) { post person_animals_path(person.id), :params => { animal: animal_params } }
    context 'parâmetros corretos' do
      let(:animal_params) { FactoryBot.attributes_for(:animal) }
      it 'cadastra um novo animal' do
        expect { request }.to change(Animal, :count).by(1)
      end
      it 'redireciona para /people/:id' do
        request
        expect(response).to redirect_to("/people/#{person.id}")
      end
      it 'exibe mensagem de sucesso' do
        request
        expect(flash[:success]).to be_present
      end
    end
    context 'parâmetros incorretos' do
      before { request }
      let(:animal_params) { { nome: '', tipo: 'Gato', custo_mensal: '0.1' } }
      it 'exibe mensagem de erro' do
        expect(flash[:error]).to be_present
      end
    end
  end
end
