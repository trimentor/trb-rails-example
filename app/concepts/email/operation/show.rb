class Email::Show < Trailblazer::Operation
  step Model(Email, :find)
end
