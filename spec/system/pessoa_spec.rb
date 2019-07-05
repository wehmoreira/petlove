require 'rails_helper'

describe 'gerenciamento de pessoas no sistema', type: :system do
  let(:attrs) { attributes_for(:pessoa) }
  context 'index' do
    context 'nenhuma pessoa cadastrada' do
      it 'exibe mensagem' do
        visit pessoas_path
        expect(page).to have_text('Não há pessoas cadastradas no momento')
      end
    end
    context 'uma ou mais pessoas cadastradas' do
      before { create_list(:pessoa, 1+rand(5)) }
      it 'carrega múltiplas pessoas na página' do
        visit pessoas_path
        expect(page).to have_text('Nome Teste da Silva', between: 1..5)
      end
      it 'exibe datas de nascimento no formato dd/mm/AAAA' do
        visit pessoas_path
        expect(page.text).to match(/\d\d?\/\d\d?\/\d{4}/)
      end
    end
  end
  context 'new' do
    before do
      visit pessoas_path
      click_link('Incluir pessoa')
    end
    it 'acessa página de cadastro de pessoa' do
      expect(page).to have_text('Incluir pessoa')
    end
    context 'parâmetros inválidos' do
      context 'não preenchendo o nome' do
        it 'exibe mensagem de erro' do
          fill_in 'pessoa[documento]', with: attrs[:documento]
          fill_in 'pessoa[data_nascimento]', with: attrs[:data_nascimento]
          click_button 'Cadastrar'
          expect(page).to have_text('Nome deve ser preenchido!')
        end
      end
      context 'não preenchendo o documento' do
        it 'exibe mensagem de erro' do
          fill_in 'pessoa[nome]', with: attrs[:nome]
          fill_in 'pessoa[data_nascimento]', with: attrs[:data_nascimento]
          click_button 'Cadastrar'
          expect(page).to have_text('Documento deve ser preenchido!')
        end
      end
      context 'não preenchendo data de nascimento' do
        it 'exibe mensagem de erro' do
          fill_in 'pessoa[nome]', with: attrs[:nome]
          fill_in 'pessoa[documento]', with: attrs[:documento]
          click_button 'Cadastrar'
          expect(page).to have_text('Data nascimento deve ser preenchido!')
        end
      end
      context 'preenchendo com data de nascimento inválida' do
        it 'exibe mensagem de erro' do
          fill_in 'pessoa[nome]', with: attrs[:nome]
          fill_in 'pessoa[documento]', with: attrs[:documento]
          fill_in 'pessoa[data_nascimento]', with: 'Lorem Ipsum Dolor Sit Amet'
          click_button 'Cadastrar'
          expect(page).to have_text('Data nascimento inválida!')
        end
      end
    end
    context 'parâmetros válidos' do
      it 'exibe mensagem de sucesso' do
        fill_in 'pessoa[nome]', with: attrs[:nome]
        fill_in 'pessoa[documento]', with: attrs[:documento]
        fill_in 'pessoa[data_nascimento]', with: attrs[:data_nascimento]
        click_button 'Cadastrar'
        expect(page).to have_text('Pessoa incluída!')
      end
    end
  end
end
