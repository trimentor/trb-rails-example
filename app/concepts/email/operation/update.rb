class Email::Update < Email::Create
  step Model(Email, :find), override: true
end
