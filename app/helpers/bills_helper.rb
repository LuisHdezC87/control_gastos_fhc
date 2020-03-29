module BillsHelper

  def get_product_name(bill_row)
    Product.find(bill_row.product_id).name || ''
  end

  def get_bill_categories(bill)
    rows = bill.try(:bill_rows) || []
    categories = []
    rows.each do |bill_row|
      categories << (bill_row.try(:product).try(:category).try(:name) || '')
    end
    categories.uniq.join(' / ')
  end

end
