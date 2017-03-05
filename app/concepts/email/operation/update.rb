class Email::Update < Email::Create
  step Model(Email, :update), override: true
end
