class Address::Update < Address::Create
  step Model(Address, :update), override: true
end
