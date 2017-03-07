module Person::Contract
  class Create < Reform::Form
    property :first_name
    property :middle_name
    property :last_name

    validates :first_name, presence: true
  end
end
