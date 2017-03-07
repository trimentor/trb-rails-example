class Birthday::Delete < Trailblazer::Operation
  step Model(Birthday, :find)
  step -> (options) { options["model"].destroy }
end
