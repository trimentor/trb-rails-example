class Phone::Delete < Trailblazer::Operation
  step Model(Phone, :find)
  step -> (options) { options["model"].destroy }
end
