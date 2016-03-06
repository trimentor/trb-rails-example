class Event::Create < Trailblazer::Operation
  include Model
  model Event, :create

  contract do
    property :name
    property :location
    property :start_time
    property :end_time
    property :description

    validates :name, presence: true
    validates :start_time, presence: true
  end

  def process(params)
    validate(params[:event], @model) do
      contract.save
    end
  end
end
