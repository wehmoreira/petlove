require 'rails_helper'

describe 'gerenciamento de pessoas no sistema', type: :system do
  let(:attrs) { attributes_for(:person) }
  context 'index' do
    context 'nenhuma pessoa cadastrada' do
      it 'exibe mensagem' do
        visit people_path
        expect(page).to have_text('Não há pessoas cadastradas no momento')
      end
    end
    context 'uma ou mais pessoas cadastradas' do
      before { create_list(:person, 1+rand(5)) }
      it 'carrega múltiplas pessoas na página' do
        visit people_path
        expect(page).to have_text('Nome Teste da Silva', between: 1..5)
      end
      it 'exibe datas de nascimento no formato dd/mm/AAAA' do
        visit people_path
        expect(page.text).to match(/\d\d?\/\d\d?\/\d{4}/)
      end
    end
  end
  context 'new' do
    before do
      visit people_path
      click_link('Incluir pessoa')
    end
    it 'acessa página de cadastro de pessoas' do
      expect(page).to have_text('Incluir pessoa')
    end
    context 'parâmetros inválidos' do
      context 'não preenchendo o nome' do
        it 'exibe mensagem de erro' do
          fill_in 'person[documento]', with: attrs[:documento]
          fill_in 'person[data_nascimento]', with: attrs[:data_nascimento]
          click_button 'Salvar'
          expect(page).to have_text('Nome não pode ficar em branco')
        end
      end
      context 'não preenchendo o documento' do
        it 'exibe mensagem de erro' do
          fill_in 'person[nome]', with: attrs[:nome]
          fill_in 'person[data_nascimento]', with: attrs[:data_nascimento]
          click_button 'Salvar'
          expect(page).to have_text('Documento não pode ficar em branco')
        end
      end
      context 'não preenchendo data de nascimento' do
        it 'exibe mensagem de erro' do
          fill_in 'person[nome]', with: attrs[:nome]
          fill_in 'person[documento]', with: attrs[:documento]
          click_button 'Salvar'
          expect(page).to have_text('Data nascimento não pode ficar em branco')
        end
      end
      context 'preenchendo com data de nascimento inválida' do
        it 'exibe mensagem de erro' do
          fill_in 'person[nome]', with: attrs[:nome]
          fill_in 'person[documento]', with: attrs[:documento]
          fill_in 'person[data_nascimento]', with: 'Lorem Ipsum Dolor Sit Amet'
          click_button 'Salvar'
          expect(page).to have_text('Data nascimento inválida!')
        end
      end
    end
    context 'parâmetros válidos' do
      it 'exibe mensagem de sucesso' do
        fill_in 'person[nome]', with: attrs[:nome]
        fill_in 'person[documento]', with: attrs[:documento]
        fill_in 'person[data_nascimento]', with: attrs[:data_nascimento]
        click_button 'Salvar'
        expect(page).to have_text('Pessoa incluída!')
      end
    end
  end
  context 'show' do
    before { create(:person, nome: 'Lorem Ipsum Dolor') }
    it 'exibe as informações da pessoa cadastrada' do
      visit people_path
      click_link 'Mostrar'
      expect(page).to have_text('Lorem Ipsum Dolor')
    end
  end
  context 'edit' do
    before do
      create(:person)
      visit people_path
      click_link('Mostrar')
      click_link('Editar pessoa')
    end
    it 'acessa página de alteração do cadastro de pessoas' do
      expect(page).to have_text('Editar pessoa')
    end
    context 'parâmetros inválidos' do
      context 'alterando nome para vazio' do
        it 'exibe mensagem de erro' do
          fill_in 'person[nome]', with: ''
          click_button 'Salvar'
          expect(page).to have_text('Nome não pode ficar em branco')
        end
      end
      context 'não preenchendo o documento' do
        it 'exibe mensagem de erro' do
          fill_in 'person[documento]', with: ''
          click_button 'Salvar'
          expect(page).to have_text('Documento não pode ficar em branco')
        end
      end
      context 'não preenchendo data de nascimento' do
        it 'exibe mensagem de erro' do
          fill_in 'person[data_nascimento]', with: ''
          click_button 'Salvar'
          expect(page).to have_text('Data nascimento não pode ficar em branco')
        end
      end
      context 'preenchendo com data de nascimento inválida' do
        it 'exibe mensagem de erro' do
          fill_in 'person[data_nascimento]', with: 'Lorem Ipsum Dolor Sit Amet'
          click_button 'Salvar'
          expect(page).to have_text('Data nascimento inválida!')
        end
      end
    end
    context 'parâmetros válidos' do
      it 'exibe mensagem de sucesso' do
        fill_in 'person[nome]', with: 'Nome Teste II'
        fill_in 'person[documento]', with: '6666666666'
        fill_in 'person[data_nascimento]', with: '01/01/1922'
        click_button 'Salvar'
        expect(page).to have_text('Pessoa alterada!')
      end
    end
  end
  context 'destroy' do
    let(:person) { create(:person) }
    it 'exibe opção de deletar pessoa' do
      visit person_path(person.id)
      click_link 'Apagar pessoa'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_text('Pessoa excluída!')
    end
  end
end
