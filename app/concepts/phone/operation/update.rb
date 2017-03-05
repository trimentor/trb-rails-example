class Phone::Update < Phone::Create
  step Model(Phone, :update), override: true
end
