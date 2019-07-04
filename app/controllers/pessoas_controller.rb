class PessoasController < ApplicationController
  def index
    @pessoas = Pessoa.all.decorate
    flash.now[:info] = 'Não há pessoas cadastradas no momento' if @pessoas.blank?
  end

  def new
  end

  def create
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end
end
