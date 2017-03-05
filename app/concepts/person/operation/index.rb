class Person::Index < Trailblazer::Operation
  step :model

  def model(options)
    options["model"] = Person.all
  end
end
