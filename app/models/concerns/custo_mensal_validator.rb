class CustoMensalValidator < ActiveModel::Validator
  def validate(record)
    if record.custo_mensal && record.person.animals.sum(:custo_mensal) + record.custo_mensal > 1000
      record.errors.add(:custo_mensal, 'de todos os animais ultrapassará 1000')
    end
  end
end
