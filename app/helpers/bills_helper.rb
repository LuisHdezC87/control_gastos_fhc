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

  def show_next_month_option(current_month)
    Date.new(current_month.last.to_i, current_month.first.to_i).at_beginning_of_month < Date.today.at_beginning_of_month
  end

  def get_link_month(month)
    "#{month.month}-#{month.year}"
  end

end
