class Event::Create < Trailblazer::Operation
  include Model
  model Event, :create

  contract do
    property :name, validates: {presence: true}
    property :location
    property :start_time, validates: {presence: true}
    property :end_time
    property :description
  end

  def process(params)
    @model = Event.new

    validate(params[:event], @model) do
      contract.save
    end
  end
end

class Event::Update < Trailblazer::Operation
  include Model
  model Event, :update

  contract do
    property :name, validates: {presence: true}
    property :location
    property :start_time, validates: {presence: true}
    property :end_time
    property :description
  end

  def process(params)
    validate(params[:event], @model) do
      contract.save
    end
  end
end
