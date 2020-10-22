class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.find_by_name(name)
    merchants = Merchant.where("lower(name) LIKE ?", "%" + name.downcase + "%")
  end

  def self.most_revenue(quantity)
    Merchant.select("merchants.*, sum(quantity * unit_price) as revenue")
    .joins(invoices: [:invoice_items, :transactions])
    .merge(Transaction.successful)
    .where(invoices: {status: :shipped})
    .group(:id)
    .order(revenue: :desc)
    .limit(quantity)
  end

  def self.most_items_sold(quantity)
    Merchant.select("merchants.*, sum(quantity) as items_sold")
    .joins(invoices: [:invoice_items, :transactions])
    .where(invoices: {status: :shipped})
    .merge(Transaction.successful).group(:id)
    .order(items_sold: :desc).limit(quantity)
  end
end
#=== 1
# Merchant.joins(:invoice_items).joins(:transactions).select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue').where("transactions.result='success'").group(:id).order('total_revenue desc').limit(quantity)

#=== 2
## This is all correct except for line 272, 273 in the test. 

#Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue").joins(items: :invoice_items).group(:id).order("total_revenue desc").limit(quantity)

#=== 3
#Merchant.select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue").joins(items: [:invoice_items, :transactions]).where("transactions.result='success' AND invoices.status='shipped'").group(:id).order("total_revenue desc").limit(quantity)