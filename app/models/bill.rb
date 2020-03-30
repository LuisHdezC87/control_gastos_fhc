class Bill < ApplicationRecord

  belongs_to :project
  belongs_to :bill_type
  belongs_to :contact
  has_many :bill_rows
  has_many :payments

  def paid?
    self.paid = self.payments.calculate(:sum, :payment_amount) < self.total_amount ? false : true
    self.paid
  end

end
