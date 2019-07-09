class AnimalsController < ApplicationController
  def create
    @person = Person.find(params[:person_id])
    @animal = @person.animals.build(permitted_params)
    @person.save ? flash[:success] = 'Animal incluído!' : flash[:error] = @animal.errors.full_messages.to_sentence

    redirect_to person_path(@person)
  end

  def edit
    @person = Person.find(params[:person_id])
    @animal = @person.animals.find(params[:id])
  end

  def update
    @person = Person.find(params[:person_id])
    @animal = @person.animals.find(params[:id])
    if @animal.update(permitted_params)
      flash[:success] = 'Animal alterado!'
    else
      flash[:error] = @animal.errors.full_messages.to_sentence
    end

    redirect_to(@person)
  end

  def destroy
    @person = Person.find(params[:person_id])
    @animal = @person.animals.find(params[:id])
    @animal.destroy
    flash[:success] = 'Animal excluído!'

    redirect_to person_path(@person)
  end

  private

  def permitted_params
    params.require(:animal).permit(:nome, :tipo, :custo_mensal)
  end
end
