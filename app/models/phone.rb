class Phone < ActiveRecord::Base
  belongs_to :person

  enum telephone_type: {
    cell_phone: 0,
    landline: 1
  }

  enum category: {
    personal_use: 0,
    work_related: 1
  }
end
