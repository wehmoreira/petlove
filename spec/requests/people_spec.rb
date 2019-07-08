require 'rails_helper'

describe 'gerenciamento de pessoas no sistema', type: :request do
  describe 'GET /people' do
    context 'nenhuma pessoa cadastrada' do
      before { get people_path }
      it 'responde com status http 200' do
        expect(response).to have_http_status(200)
      end
      it 'exibe uma mensagem' do
        expect(flash[:info]).to be_present
      end
    end
    context 'várias pessoas cadastradas' do
      it 'não deve exibir uma mensagem' do
        create_list(:person, 3)
        get people_path
        expect(flash[:info]).not_to be_present
      end
    end
  end
  describe 'GET /people/new' do
    before { allow(Person).to receive(:new).and_return(Person.new) }
    it 'renderiza `new`' do
      get new_person_path
      assert_response :success
    end
  end
  describe 'POST /people' do
    let(:request) { post people_path, :params => { :person => person_params } }
    context 'parâmetros corretos' do
      let(:person_params) { FactoryBot.attributes_for(:person) }
      it 'cadastra uma nova pessoa' do
        expect { request }.to change(Person, :count).by(1)
      end
      it 'redireciona para /people/:id' do
        request
        expect(response).to redirect_to("/people/#{Person.first.id}")
      end
      it 'exibe informação de sucesso' do
        request
        expect(flash[:success]).to be_present
      end
    end
    context 'parâmetros incorretos' do
      before { request }
      let(:person_params) { { nome: '', documento: '555555555', data_nascimento: '28/08/1991' } }
      it 'exibe informação de erro' do
        expect(flash[:error]).to be_present
      end
      it 'renderiza `new`' do
        assert_response :success
      end
    end
  end
  describe 'GET /people/:id' do
    before { allow(Person).to receive(:find).with(person.id.to_s).and_return(person) }
    let(:person) { create(:person) }
    it 'renderiza `show`' do
      get person_path(person.id)
      assert_response :success
    end
  end
  describe 'GET /people/:id/edit' do
    before { allow(Person).to receive(:find).with(person.id.to_s).and_return(person) }
    let(:person) { create(:person) }
    it 'renderiza `edit`' do
      get edit_person_path(person.id)
      assert_response :success
    end
  end
  describe 'PATCH /people/:id' do
    before do
      request
      allow(Person).to receive(:find).with(person.id).and_return(person)
    end
    let(:person) { create(:person) }
    let(:request) { patch person_path(person.id), :params => { :person => person_params } }
    context 'parâmetros corretos' do
      let(:person_params) { FactoryBot.attributes_for(:person).merge(nome: "Nome Alterado") }
      it 'altera os dados de uma pessoa' do
        expect(Person.first.nome).to eq("Nome Alterado")
      end
      it 'redireciona para /people/:id' do
        expect(response).to redirect_to("/people/#{person.id}")
      end
      it 'exibe informação de sucesso' do
        expect(flash[:success]).to be_present
      end
    end
  end
  describe 'DELETE /people/:id' do
    before { person }
    let(:person) { create(:person) }
    it 'deve apagar a pessoa do sistema' do
      expect { delete person_path(person.id) }.to change(Person, :count).by(-1)
    end
    it 'exibe informação de sucesso' do
      delete person_path(person.id)
      expect(flash[:success]).to be_present
    end
    it 'redireciona para `index`' do
      delete person_path(person.id)
      expect(response).to redirect_to("/people")
    end
  end
end
