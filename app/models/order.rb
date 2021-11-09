class Order < ApplicationRecord
  belongs_to :end_user
  has_many :order_details
  enum payment_method: { card: 0, cash: 1 }
  enum is_order: { payment_waiting: 0, confirm: 1, running: 2, shipment_waiting: 3, executed: 4 }
end
