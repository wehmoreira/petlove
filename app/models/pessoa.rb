class Pessoa < ApplicationRecord
  validates :nome, presence: true
  validates :documento, presence: true
  validates :data_nascimento, presence: true, format: { with: /\d{4}-\d\d?-\d\d? \d\d?:\d\d?:\d\d?/ }
end
