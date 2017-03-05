class Event::Update < Event::Create
  step Model(Event, :find), override: true
end
