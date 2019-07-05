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
end
