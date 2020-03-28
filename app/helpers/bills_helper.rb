module BillsHelper

  def get_product_name(bill_row)
    Product.find(bill_row.product_id).name || ''
  end

end
