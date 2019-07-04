require 'rails_helper'

describe "Pessoas", type: :request do
  describe "GET /pessoas" do
    before { get pessoas_path }
    context 'nenhuma pessoa cadastrada' do
      it "works!" do
        expect(response).to have_http_status(200)
      end
      it 'retorna uma mensagem' do
        expect(flash[:info]).to be_present
      end
    end
  end
end
