module Email::Contract
  class Create < Reform::Form
    property :person_id
    property :address
    property :category

    validates :person_id, presence: true
    validates :address, presence: true
    validates :category, inclusion: {in: Email.categories.values}
  end
end
