class Phone::Update < Phone::Create
  step Model(Phone, :find), override: true
end
