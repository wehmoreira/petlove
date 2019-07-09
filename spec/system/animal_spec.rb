require 'rails_helper'

describe 'gerenciamento de animais', type: :system do
  let(:attrs) { attributes_for(:animal) }
  context 'na página de uma pessoa' do
    before { visit person_path(person.id) }
    context 'listagem de animais por dono' do
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
    context 'cadastrando um animal' do
      context 'parâmetros válidos' do
        let(:person) { create(:person) }
        it 'exibe mensagem de sucesso' do
          fill_in 'animal[nome]', with: attrs[:nome]
          fill_in 'animal[tipo]', with: attrs[:tipo]
          fill_in 'animal[custo_mensal]', with: attrs[:custo_mensal]
          click_button 'Salvar'
          expect(page).to have_text('Animal incluído!')
        end
      end
      context 'parâmetros inválidos' do
        context 'nome' do
          let(:person) { create(:person) }
          context 'não preenchendo' do
            it 'exibe mensagem de erro' do
              fill_in 'animal[tipo]', with: attrs[:tipo]
              fill_in 'animal[custo_mensal]', with: attrs[:custo_mensal]
              click_button 'Salvar'
              expect(page).to have_text('Nome não pode ficar em branco')
            end
          end
        end
        context 'tipo' do
          context 'não preenchendo' do
            let(:person) { create(:person) }
            it 'exibe mensagem de erro' do
              fill_in 'animal[nome]', with: attrs[:nome]
              fill_in 'animal[custo_mensal]', with: attrs[:custo_mensal]
              click_button 'Salvar'
              expect(page).to have_text('Tipo não pode ficar em branco')
            end
          end
          context 'andorinha para dono menor de 18 anos' do
            let(:person) { create(:person, data_nascimento: 9.years.ago) }
            it 'exibe mensagem de erro' do
              fill_in 'animal[nome]', with: attrs[:nome]
              fill_in 'animal[tipo]', with: 'Andorinha'
              fill_in 'animal[custo_mensal]', with: attrs[:custo_mensal]
              click_button 'Salvar'
              expect(page).to have_text('Tipo andorinha só para donos maiores de 18 anos')
            end
          end
          context 'gato para dono com inicial diferente de `A`' do
            let(:person) { create(:person, nome: 'Augusto dos Anjos') }
            it 'exibe mensagem de erro' do
              fill_in 'animal[nome]', with: attrs[:nome]
              fill_in 'animal[tipo]', with: 'gato'
              fill_in 'animal[custo_mensal]', with: attrs[:custo_mensal]
              click_button 'Salvar'
              expect(page).to have_text('Tipo gato só para donos sem inicial `A`')
            end
          end
        end
        context 'custo_mensal' do
          let(:person) { create(:person) }
          context 'não preenchendo' do
            it 'exibe mensagem de erro' do
              fill_in 'animal[nome]', with: attrs[:nome]
              fill_in 'animal[tipo]', with: attrs[:tipo]
              click_button 'Salvar'
              expect(page).to have_text('Custo mensal não é um número')
            end
          end
          context 'inválido' do
            it 'exibe mensagem de erro' do
              fill_in 'animal[nome]', with: attrs[:nome]
              fill_in 'animal[tipo]', with: attrs[:tipo]
              fill_in 'animal[custo_mensal]', with: 'Lorem Ipsum'
              click_button 'Salvar'
              expect(page).to have_text('Custo mensal não é um número')
            end
          end
          context 'excedendo 1000 do custo total dos animais' do
            before { create(:animal, custo_mensal: 999.99, person_id: person.id) }
            it 'exibe mensagem de erro' do
              fill_in 'animal[nome]', with: attrs[:nome]
              fill_in 'animal[tipo]', with: attrs[:tipo]
              fill_in 'animal[custo_mensal]', with: attrs[:custo_mensal]
              click_button 'Salvar'
              expect(page).to have_text('Custo mensal de todos os animais ultrapassará 1000')
            end
          end
        end
      end
    end
  end
  context 'editando um animal' do
    before { visit edit_person_animal_path(person.id, animal.id) }
    let(:person) { create(:person_with_animals) }
    let(:animal) { person.animals.first }
    context 'parâmetros válidos' do
      it 'exibe mensagem de sucesso' do
        fill_in 'animal[nome]', with: attrs[:nome]
        fill_in 'animal[tipo]', with: attrs[:tipo]
        fill_in 'animal[custo_mensal]', with: attrs[:custo_mensal]
        click_button 'Salvar'
        expect(page).to have_text('Animal alterado!')
      end
    end
    context 'parâmetros inválidos' do
      context 'nome' do
        context 'não preenchendo' do
          it 'exibe mensagem de erro' do
            fill_in 'animal[nome]', with: ''
            click_button 'Salvar'
            expect(page).to have_text('Nome não pode ficar em branco')
          end
        end
      end
      context 'tipo' do
        context 'não preenchendo' do
          it 'exibe mensagem de erro' do
            fill_in 'animal[tipo]', with: ''
            click_button 'Salvar'
            expect(page).to have_text('Tipo não pode ficar em branco')
          end
        end
        context 'andorinha para dono menor de 18 anos' do
          let(:person) { create(:person, data_nascimento: 9.years.ago) }
          let(:animal) { create(:animal, person_id: person.id) }
          it 'exibe mensagem de erro' do
            fill_in 'animal[tipo]', with: 'Andorinha'
            click_button 'Salvar'
            expect(page).to have_text('Tipo andorinha só para donos maiores de 18 anos')
          end
        end
        context 'gato para dono com inicial diferente de `A`' do
          let(:person) { create(:person, nome: 'Augusto dos Anjos') }
          let(:animal) { create(:animal, person_id: person.id) }
          it 'exibe mensagem de erro' do
            fill_in 'animal[tipo]', with: 'gato'
            click_button 'Salvar'
            expect(page).to have_text('Tipo gato só para donos sem inicial `A`')
          end
        end
      end
      context 'custo_mensal' do
        context 'não preenchendo' do
          it 'exibe mensagem de erro' do
            fill_in 'animal[custo_mensal]', with: ''
            click_button 'Salvar'
            expect(page).to have_text('Custo mensal não é um número')
          end
        end
        context 'inválido' do
          it 'exibe mensagem de erro' do
            fill_in 'animal[custo_mensal]', with: 'Lorem Ipsum'
            click_button 'Salvar'
            expect(page).to have_text('Custo mensal não é um número')
          end
        end
        context 'excedendo 1000 do custo total dos animais' do
          it 'exibe mensagem de erro' do
            fill_in 'animal[custo_mensal]', with: 999.99
            click_button 'Salvar'
            expect(page).to have_text('Custo mensal de todos os animais ultrapassará 1000')
          end
        end
      end
    end
  end
end
