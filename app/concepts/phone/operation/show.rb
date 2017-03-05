class Phone::Show < Trailblazer::Operation
  step Model(Phone, :find)
end
