module Phone::Contract
  # TODO: Implement Phonelib to validate the telephone numbers.
  # https://github.com/daddyz/phonelib
  class Create < Reform::Form
    property :person_id
    property :telephone_number
    property :telephone_type
    property :category

    validates :person_id, presence: true
    validates :telephone_number, presence: true
    validates :telephone_type, inclusion: {in: Phone.telephone_types.values}
    validates :category, inclusion: {in: Phone.categories.values}
  end
end
