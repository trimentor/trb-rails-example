class Person::Index < Trailblazer::Operation
  def process(params)
    @model = Person.all
  end
end
