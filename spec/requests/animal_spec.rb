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
  describe 'GET /people/:person_id/animals/:id/edit' do
    before do
      allow(Person).to receive(:find).with(person.id.to_s).and_return(person)
      allow(person).to receive_message_chain('animals.find').with(animal.id.to_s).and_return(animal)
    end
    let(:person) { create(:person_with_animals) }
    let(:animal) { person.animals.first }
    it 'renderiza `edit`' do
      get edit_person_animal_path(person.id, animal.id)
      assert_response :success
    end
  end
  describe 'PATCH /people/:person_id/animals/:id' do
    before do
      request
      allow(Person).to receive(:find).with(person.id).and_return(person)
    end
    let(:person) { create(:person_with_animals) }
    let(:animal) { person.animals.first }
    let(:request) { patch person_animal_path(person.id, animal.id), :params => { animal: animal_params } }
    context 'parâmetros corretos' do
      let(:animal_params) { FactoryBot.attributes_for(:animal).merge(nome: "Petname Alterado") }
      it 'altera os dados de uma pessoa' do
        expect(Animal.first.nome).to eq("Petname Alterado")
      end
      it 'redireciona para /people/:id' do
        expect(response).to redirect_to("/people/#{person.id}")
      end
      it 'exibe informação de sucesso' do
        expect(flash[:success]).to be_present
      end
    end
  end
  describe 'DELETE /people/:person_id/animals/:id' do
    before do
      person
    end
    let(:person) { create(:person_with_animals) }
    let(:animal) { person.animals.first }
    it 'deve apagar o animal do sistema' do
      expect { delete person_animal_path(person.id, animal.id) }.to change(Animal, :count).by(-1)
    end
    it 'exibe informação de sucesso' do
      delete person_animal_path(person.id, animal.id)
      expect(flash[:success]).to be_present
    end
    it 'redireciona para `index`' do
      delete person_animal_path(person.id, animal.id)
      expect(response).to redirect_to("/people/#{person.id}")
    end
  end
end
