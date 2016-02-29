class Person::Delete < Trailblazer::Operation
  include Model
  model Person, :find

  def process(params)
    model.destroy
  end
end
