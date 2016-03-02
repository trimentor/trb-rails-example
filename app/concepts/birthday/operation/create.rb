class Birthday::Create < Trailblazer::Operation
  include Model
  model Birthday, :create

  contract do
    property :person_id, validates: {presence: true}
    property :event_id # Set if param start_time is present and event is created
  end

  def process(params)
    validate(params[:birthday], model) do
      res, op = Birthday::Show.run(person_id: params[:birthday][:person_id])

      if !res
        event = create_event(params)
        @model = Birthday.create(person_id: params[:birthday][:person_id], event_id: event.id)
      else
        @model = op.model # Allow to display existing birthday info
        errors.add(:person_id, 'can only have one birthday')
      end

      @valid = errors.empty? && @model.valid? # Birthday::Create.run must return correct result
    end
  end

  private

  def create_event(params)
    res, op = Event::Create.run(event: params[:birthday].merge(name: 'birthday'))

    unless res
      merge_event_operation_errors!(op)
    end

    op.model
  end

  def merge_event_operation_errors!(op)
    self.errors.details.merge!(op.errors.details)
    self.errors.messages.merge!(op.errors.messages)
  end
end
