class PeopleController < ApplicationController
  def index
    @people = Person.all.decorate
    flash.now[:info] = 'Não há pessoas cadastradas no momento' if @people.blank?
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(permitted_params)
    if @person.save
      flash[:success] = 'Pessoa incluída!'
      redirect_to @person
    else
      flash.now[:error] = @person.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def show
    @person = Person.find(params[:id]).decorate
    flash[:info] = 'Nenhum animal cadastrado para esta pessoa' if @person.animals.empty?
  end

  def update
    @person = Person.find(params[:id])

    if @person.update(permitted_params)
      flash[:success] = 'Pessoa incluída!'
    else
      flash[:error] = @person.errors.full_messages.to_sentence
    end

    redirect_to @person
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    flash[:success] = 'Pessoa excluída!'

    redirect_to people_path
  end

  private

  def permitted_params
    params.require(:person).permit(:nome, :documento, :data_nascimento)
  end
end
