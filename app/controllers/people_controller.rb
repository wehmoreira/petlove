class PeopleController < ApplicationController
  def index
    @people = Person.all.decorate
    flash.now[:info] = 'Não há pessoas cadastradas no momento' if @people.blank?
  end

  def new
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
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def permitted_params
    params.require(:person).permit(:nome, :documento, :data_nascimento)
  end
end
