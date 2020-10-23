class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.find_by_name(name)
    Item.where("lower(name) LIKE ?", "%" + name.downcase + "%")
  end
end
