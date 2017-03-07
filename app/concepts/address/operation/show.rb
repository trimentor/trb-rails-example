class Address::Show < Trailblazer::Operation
  step Model(Address, :find)
end
