module Birthday::Contract
  class Create < Reform::Form
    property :person_id, validates: {presence: true}
    property :event_id # Set if param start_time is present and event is created
  end
end
