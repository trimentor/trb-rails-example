class Email < ActiveRecord::Base
  belongs_to :person

  enum category: {
    personal_use: 0,
    work_related: 1
  }
end
