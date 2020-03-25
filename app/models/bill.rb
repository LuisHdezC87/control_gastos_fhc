class Bill < ApplicationRecord

  belongs_to :project
  belongs_to :bill_type
  belongs_to :contact
  has_many :bill_rows

end
