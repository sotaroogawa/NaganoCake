class OrderDetail < ApplicationRecord
  belongs_to :order, dependent: :destroy
  belongs_to :item
  enum is_making: { no_running: 0, produce_waiting: 1, produce_running: 2,  produce_executed: 3 }

  def add_tax_price
        (self.price * 1.1).round
  end

end
