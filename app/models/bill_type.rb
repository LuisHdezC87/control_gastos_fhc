class BillType < ApplicationRecord

  has_many :bills
  belongs_to :project

  validates :name, presence: true

end
