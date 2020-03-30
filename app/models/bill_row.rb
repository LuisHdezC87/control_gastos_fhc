class BillRow < ApplicationRecord

  belongs_to :bill
  belongs_to :product

end
