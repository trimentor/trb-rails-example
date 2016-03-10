class Person::Cell < Cell::Concept
  property :first_name
  property :middle_name
  property :last_name

  def show
    render
  end
end
