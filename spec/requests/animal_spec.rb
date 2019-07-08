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
end
