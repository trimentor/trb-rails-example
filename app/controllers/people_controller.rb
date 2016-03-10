class PeopleController < ApplicationController
  def index
    run Person::Index
  end

  def show
    run Person::Show do |op|
      render html: concept('person/cell', op.model), layout: true
    end
  end

  def new
    form Person::Create
  end

  def create
    run Person::Create do |op|
      return redirect_to person_path(op.model)
    end

    render :new
  end

  def edit
    form Person::Update
    render :new
  end

  def update
    run Person::Update do |op|
      flash[:notice] = "Person has been updated successfully!"
      return redirect_to person_path(op.model)
    end

    render :new
  end

  def destroy
    run Person::Delete do |op|
      flash[:notice] = "Person has been deleted successfully!"
    end

    redirect_to people_path
  end
end
