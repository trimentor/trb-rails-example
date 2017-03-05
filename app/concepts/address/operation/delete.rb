class Address::Delete < Trailblazer::Operation
  step Model(Address, :find)
  step -> (options) { options["model"].destroy }
end
