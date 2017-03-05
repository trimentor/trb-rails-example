class Birthday::Delete < Trailblazer::Operation
  extend Contract::DSL

  step Model(Birthday, :find)
  step -> (options) { options["model"].destroy }
end
