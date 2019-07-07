class CustoMensalValidator < ActiveModel::Validator
  MAX_CUSTO = 1000
  def validate(record)
    if record.custo_mensal && record.person.animals.sum(:custo_mensal) + record.custo_mensal > MAX_CUSTO
      record.errors.add(:custo_mensal, "de todos os animais ultrapassará #{MAX_CUSTO}")
    end
  end
end
