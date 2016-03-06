class Phone::Create < Trailblazer::Operation
  include Model
  model Phone, :create

  # TODO: Implement Phonelib to validate the telephone numbers.
  # https://github.com/daddyz/phonelib
  contract do
    property :person_id
    property :telephone_number
    property :telephone_type
    property :category

    validates :person_id, presence: true
    validates :telephone_number, presence: true
    validates :telephone_type, inclusion: {in: Phone.telephone_types.values}
    validates :category, inclusion: {in: Phone.categories.values}
  end

  def process(params)
    validate(params[:phone], @model) do
      contract.save
    end
  end
end
