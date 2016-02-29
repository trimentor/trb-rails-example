class Person::Show < Trailblazer::Operation
  include Model
  model Person, :find

  def process(params)
  end
end
