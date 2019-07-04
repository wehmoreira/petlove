class PessoaDecorator < Draper::Decorator
  delegate_all

  def data_nascimento_formatada
    data_nascimento.strftime('%d/%m/%Y')
  end
end
