class PessoasController < ApplicationController
  def index
    @pessoas = Pessoa.all.decorate
    flash.now[:info] = 'Não há pessoas cadastradas no momento' if @pessoas.blank?
  end

  def new
  end

  def create
    @pessoa = Pessoa.new(permitted_params)
    if @pessoa.save
      flash[:success] = 'Pessoa incluída!'
      redirect_to @pessoa
    else
      flash.now[:error] = @pessoa.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def permitted_params
    params.require(:pessoa).permit(:nome, :documento, :data_nascimento)
  end
end
