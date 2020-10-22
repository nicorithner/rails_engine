class Revenue
  
  def self.date_range(start_date, end_date)
    # binding.pry
    Invoice.joins(:invoice_items, :transactions)
    .merge(Transaction.successful)
    .where(status: :shipped, created_at: Date.parse(start_date).beginning_of_day..Date.parse(end_date).end_of_day)
    .sum('invoice_items.quantity * invoice_items.unit_price')
  end
end