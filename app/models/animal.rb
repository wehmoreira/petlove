class Animal < ApplicationRecord
  belongs_to :person

  validates :nome, presence: true
  validates :tipo, presence: true
  validates :custo_mensal, numericality: { greater_than_or_equal_to: 0 }

  def custo_mensal=(valor)
    super(valor.gsub(/,/, '.'))
  end
end
