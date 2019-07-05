require 'rails_helper'

describe 'gerenciamento de Pessoas no sistema', type: :request do
  describe 'GET /pessoas' do
    context 'nenhuma pessoa cadastrada' do
      before { get pessoas_path }
      it 'responde com status http 200' do
        expect(response).to have_http_status(200)
      end
      it 'exibe uma mensagem' do
        expect(flash[:info]).to be_present
      end
    end
    context 'várias pessoas cadastradas' do
      it 'não deve exibir uma mensagem' do
        create_list(:pessoa, 3)
        get pessoas_path
        expect(flash[:info]).not_to be_present
      end
    end
  end
  describe 'POST /pessoas' do
    let(:request) { post pessoas_path, :params => { :pessoa => pessoa_params } }
    context 'parâmetros corretos' do
      let(:pessoa_params) { FactoryBot.attributes_for(:pessoa) }
      it 'cadastra uma nova pessoa' do
        expect { request }.to change(Pessoa, :count).by(1)
      end
      it 'redireciona para /pessoas/:id' do
        request
        expect(response).to redirect_to("/pessoas/#{Pessoa.first.id}")
      end
      it 'exibe informação de sucesso' do
        request
        expect(flash[:success]).to be_present
      end
    end
    context 'parâmetros incorretos' do
      before { request }
      let(:pessoa_params) { { nome: '', documento: '555555555', data_nascimento: '28/08/1991' } }
      it 'exibe informação de erro' do
        expect(flash[:error]).to be_present
      end
      it 'renderiza `new`' do
        assert_response :success
      end
    end
  end
end
