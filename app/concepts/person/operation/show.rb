class Person::Show < Trailblazer::Operation
  step Model(Person, :find)
end
