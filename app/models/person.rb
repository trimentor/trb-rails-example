class Person < ActiveRecord::Base
  has_many :emails

  has_many :phones

  has_one :domicile

  has_one :address, through: :domicile

  has_one :birthday

  has_one :birthdate, through: :birthday, source: :event
end
