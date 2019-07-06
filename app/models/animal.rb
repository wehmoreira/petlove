class Animal < ApplicationRecord
  belongs_to :person

  validates :nome, presence: true
  validates :tipo, presence: true
  validates :custo_mensal, numericality: { greater_than_or_equal_to: 0 }
  validate  :maioridade
  validate  :inicial_do_nome
  validate  :limite_custo_mensal

  def custo_mensal=(valor)
    super(valor.to_s.gsub(/,/, '.'))
  end

  private

  def maioridade
    if tipo =~ /andorinha/i && person.data_nascimento >= 18.years.ago
      errors.add(:tipo, 'andorinha apenas com donos maiores de 18 anos')
    end
  end

  def inicial_do_nome
    if tipo =~ /gato/i && person.nome =~ /^[aA]/
      errors.add(:tipo, 'gato somente para donos com nomes que não começam com `A`')
    end
  end

  def limite_custo_mensal
    if custo_mensal && person.animals.sum(:custo_mensal) + custo_mensal > 1000
      errors.add(:custo_mensal, 'de todos os animais ultrapassará 1000')
    end
  end
end
