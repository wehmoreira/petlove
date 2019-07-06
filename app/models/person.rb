class Person < ApplicationRecord
  validates :nome, presence: true
  validates :documento, presence: true
  validates :data_nascimento, presence: true
  validates_with PersonValidator
end
