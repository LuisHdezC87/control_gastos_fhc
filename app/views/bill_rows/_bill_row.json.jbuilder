json.extract! bill_row, :id, :price, :product_id, :amount, :created_at, :updated_at
json.url bill_row_url(bill_row, format: :json)
