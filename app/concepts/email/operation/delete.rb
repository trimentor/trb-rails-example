class Email::Delete < Trailblazer::Operation
  step Model(Email, :find)
  step -> (options) { options["model"].destroy }
end
