class Event::Create < Trailblazer::Operation
  extend Contract::DSL

  contract do
    property :name
    property :location
    property :start_time
    property :end_time
    property :description

    validates :name, presence: true
    validates :start_time, presence: true
  end

  step Model(Event, :new)
  step Contract::Build()
  step Contract::Validate()
  step Contract::Persist()
end
