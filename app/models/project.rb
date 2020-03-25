class Project < ApplicationRecord

  has_many :incomes
  has_many :categories
  has_many :bill_types
  has_many :bills

end
