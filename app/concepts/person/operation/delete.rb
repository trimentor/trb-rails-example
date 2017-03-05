class Person::Delete < Trailblazer::Operation
  step Model(Person, :find)
  step -> (options) { options["model"].destroy }
end
