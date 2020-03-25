class Category < ApplicationRecord

  belongs_to :project
  has_many :products

end
