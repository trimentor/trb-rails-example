module Event::Contract
  class Create < Reform::Form
    property :name
    property :location
    property :start_time
    property :end_time
    property :description

    validates :name, presence: true
    validates :start_time, presence: true
  end
end
