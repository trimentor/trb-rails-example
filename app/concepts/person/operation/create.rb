class Person::Create < Trailblazer::Operation
  include Model
  model Person, :create

  contract do
    property :first_name
    property :middle_name
    property :last_name

    validates :first_name, presence: true
  end

  def process(params)
    validate(params[:person], @model) do
      contract.save
    end
  end
end
