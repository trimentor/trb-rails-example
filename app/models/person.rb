class Person < ActiveRecord::Base
  has_many :emails

  has_many :phones

  has_one :domicile
end
