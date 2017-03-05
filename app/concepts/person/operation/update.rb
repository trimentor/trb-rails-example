class Person::Update < Person::Create
  step Model(Person, :find), override: true
end
