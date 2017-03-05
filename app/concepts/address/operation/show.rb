class Address::Show < Trailblazer::Operation
  extend Contract::DSL

  step Model(Address, :find)
end
