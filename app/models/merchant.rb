class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def self.find_by_name(name)
    Merchant.where('lower(name) LIKE ?', '%' + name.downcase + '%')
  end

  def self.most_revenue(quantity)
    Merchant.select('merchants.*, sum(quantity * unit_price) as revenue')
    .joins(invoices: [:invoice_items, :transactions]).where(invoices: {status: :shipped})
    .merge(Transaction.successful).group(:id).order(revenue: :desc).limit(quantity)
  end

  def self.most_items_sold(quantity)
    Merchant.select('merchants.*, sum(quantity) as items_sold')
    .joins(invoices: [:invoice_items, :transactions]).where(invoices: { status: :shipped })
    .merge(Transaction.successful).group(:id).order(items_sold: :desc).limit(quantity)
  end
end
