class Address::Update < Address::Create
  step Model(Address, :find), override: true
end
