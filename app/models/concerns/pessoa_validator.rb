class PessoaValidator < ActiveModel::Validator
  def validate(record)
    begin
      Date.parse(record.data_nascimento.to_s)
    rescue ArgumentError
      record.errors.add(:data_nascimento, 'data inválida')
    end
  end
end
