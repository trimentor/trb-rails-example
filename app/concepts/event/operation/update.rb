class Event::Update < Event::Create
  step Model(Event, :update), override: true
end
