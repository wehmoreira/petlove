class Pessoa < ApplicationRecord
  ERROR_MSG = 'deve ser preenchido!'
  validates :nome, presence: { message: ERROR_MSG }
  validates :documento, presence: { message: ERROR_MSG }
  validates :data_nascimento, presence: { message: ERROR_MSG }
  validates_with PessoaValidator
end
