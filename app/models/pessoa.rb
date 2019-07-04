class Pessoa < ApplicationRecord
  validates :nome, presence: true
  validates :documento, presence: true
  validates :data_nascimento, presence: true
end
