desc "Import CSV data"
task import: :environment do
  require 'csv'

  models = [Transaction, InvoiceItem, Item, Invoice, Merchant, Customer]
  models.each do |model|
    model.destroy_all
  end

  CSV.foreach("./data/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create!(row.to_h)
    end
    puts "#{Customer} data imported!"

  CSV.foreach("./data/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create!(row.to_h)
  end
  puts "#{Merchant} data imported!"
  CSV.foreach("./data/invoices.csv", headers: true, header_converters: :symbol) do |row|
      Invoice.create!(row.to_h )
  end
  puts "#{Invoice} data imported!"

  CSV.foreach("./data/items.csv", headers: true, header_converters: :symbol) do |row|
      Item.create!(
      id: row[0],
      name: row[1],
      description: row[2],
      unit_price: (row[3].to_f * 0.01).round(2),
      merchant_id: row[4],
      created_at: row[5],
      updated_at: row[6]
      )
  end
  puts "#{Item} data imported!"

  CSV.foreach("./data/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!(
      id: row[0],
      item_id: row[1],
      invoice_id: row[2],
      quantity: row[3],
      unit_price: (row[4].to_f * 0.01).round(2),
      created_at: row[5],
      updated_at: row[6]
      )
  end
  puts "#{InvoiceItem} data imported!"

  CSV.foreach("./data/transactions.csv", headers: true, header_converters: :symbol) do |row|
      Transaction.create!(row.to_h)
  end
  puts "#{Transaction} data imported!"

  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.reset_pk_sequence!(table)
  end
end
