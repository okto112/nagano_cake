class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_payment: 0, payment_confirm: 1, in_production: 2, preparing_ship: 3, shipped: 4 }
  has_many :order_details, dependent: :destroy
end
