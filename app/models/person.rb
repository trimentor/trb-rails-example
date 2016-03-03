class Person < ActiveRecord::Base
  has_many :emails

  has_many :phones
end
