class ItemSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :unit_price
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
