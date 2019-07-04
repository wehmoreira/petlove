require 'rails_helper'

describe 'gerenciamento de pessoas no sistema', type: :system do
  context 'nenhuma pessoa cadastrada' do
    it 'exibe mensagem' do
      visit pessoas_path
      expect(page).to have_text('Não há pessoas cadastradas no momento')
    end
  end
end
