class TipoValidator < ActiveModel::Validator
  def validate(record)
    return unless record.person
    case record.tipo
    when /andorinha/i
      record.errors.add(:tipo, 'andorinha só para donos maiores de 18 anos') if record.person.data_nascimento >= 18.years.ago
    when /gato/i
      record.errors.add(:tipo, 'gato só para donos sem inicial `A`') if record.person.nome =~ /^[aA]/
    end
  end
end
