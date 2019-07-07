class Person < ApplicationRecord
  has_many  :animals, dependent: :delete_all

  validates :nome, presence: true
  validates :documento, presence: true
  validates :data_nascimento, presence: true
  validates_with PersonValidator
end
