json.extract! bill, :id, :project_id, :total_amount, :purchase_date, :contact_id, :bill_type_id, :created_at, :updated_at
json.url bill_url(bill, format: :json)
