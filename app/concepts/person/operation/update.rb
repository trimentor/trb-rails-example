class Person::Update < Person::Create
  step Model(Person, :update), override: true
end
