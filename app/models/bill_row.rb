class BillRow < ApplicationRecord

  belongs_to :bill
  has_one :product

end
