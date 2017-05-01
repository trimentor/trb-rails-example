class PeopleController < ApplicationController
  def index
    @people = Person::Index.()["model"]
  end

  def show
    model = Person::Show.(id: params[:id])["model"]
    render html: concept('person/cell', model), layout: true
  end

  def new
    @form = Person::Create.(params[:person])["model"]
  end

  def create
    res = Person::Create.(params[:person])
    if res.success?
      redirect_to person_path(res["model"])
    else
      @form = res["model"]
      render :new
    end
  end

  def edit
    @form = Person::Update.(id: params[:id])["model"]
    render :new
  end

  def update
    res = Person::Update.({id: params[:id]}.merge(person_params))
    if res.success?
      flash[:notice] = "Person has been updated successfully!"
      redirect_to person_path(res["model"])
    else
      @form = res["model"]
      render :new
    end
  end

  def destroy
    res = Person::Delete.(id: params[:id])
    if res.success?
      flash[:notice] = "Person has been deleted successfully!"
    end

    redirect_to people_path
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :middle_name, :last_name)
  end
end
