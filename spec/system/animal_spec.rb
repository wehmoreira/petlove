require 'rails_helper'

describe 'gerenciamento de animais', type: :system do
  context 'listagem de animais por dono' do
    before { visit person_path(person.id) }
    context 'nenhum animal cadastrado para um dono' do
      let(:person) { create(:person) }
      it 'exibe mensagem' do
        expect(page).to have_text('Nenhum animal cadastrado para esta pessoa')
      end
    end
    let(:person) { create(:person_with_animals) }
    it 'lista os animais cadastrados para a pessoa' do
      expect(page).to have_text(person.animals.first.nome)
    end
  end
end
