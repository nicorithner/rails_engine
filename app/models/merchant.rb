class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

    def self.find_by_name(name)
    merchants = Merchant.where("lower(name) LIKE ?", "%" + name.downcase + "%")
  end
end
