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
end
