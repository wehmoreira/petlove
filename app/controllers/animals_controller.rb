class AnimalsController < ApplicationController
  def create
    @person = Person.find(params[:person_id])
    @animal = @person.animals.build(permitted_params)
    @person.save ? flash[:success] = 'Animal incluído!' : flash[:error] = @animal.errors.full_messages.to_sentence

    redirect_to person_path(@person)
  end

  private

  def permitted_params
    params.require(:animal).permit(:nome, :tipo, :custo_mensal)
  end
end
