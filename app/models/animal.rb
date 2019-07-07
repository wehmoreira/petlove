class Animal < ApplicationRecord
  belongs_to :person

  validates :nome, presence: true
  validates :tipo, presence: true
  validates :custo_mensal, numericality: { greater_than_or_equal_to: 0 }
  validates_with TipoValidator, CustoMensalValidator

  def custo_mensal=(valor)
    super(valor.to_s.gsub(/,/, '.'))
  end
end
