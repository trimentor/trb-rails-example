class Person::Create < Trailblazer::Operation
  include Model
  model Person, :create

  contract do
    property :first_name, validates: {presence: true}
    property :middle_name
    property :last_name
  end

  def process(params)
    validate(params[:person], @model) do
      contract.save
    end
  end
end
