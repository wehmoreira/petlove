require 'rails_helper'

describe 'gerenciamento de pessoas no sistema', type: :system do
  context 'index' do
    context 'nenhuma pessoa cadastrada' do
      it 'exibe mensagem' do
        visit pessoas_path
        expect(page).to have_text('Não há pessoas cadastradas no momento')
      end
    end
    context 'uma ou mais pessoas cadastradas' do
      it 'carrega múltiplas pessoas na página' do
        create_list(:pessoa, 1+rand(5))
        visit pessoas_path
        expect(page).to have_text('Nome Teste da Silva', between: 1..5)
      end
    end
  end
end
